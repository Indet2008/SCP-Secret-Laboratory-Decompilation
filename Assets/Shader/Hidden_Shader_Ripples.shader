Shader "Hidden/Shader/Ripples"
{
	Properties
	{
		_MainTex ("Main Texture", 2DArray) = "grey" {}
	}
	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" }
		Pass
		{
			Name "Ripples: Radial"
			Tags { "RenderPipeline" = "HDRenderPipeline" }
			ZTest Always
			ZWrite Off
			Cull Off
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 4060

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			#if defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT
			static float4 gl_Position;
			static int gl_VertexIndex;
			static int gl_BaseVertexARB;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				uint gl_VertexIndex : SV_VertexID;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 gl_Position : SV_Position;
			};

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

			void vert_main()
			{
				uint vertex_unnamed_22 = 1u & 31u;
				float vertex_unnamed_34 = float(spvBitfieldInsert(0u, uint(gl_VertexIndex) - uint(gl_BaseVertexARB), vertex_unnamed_22, min((1u & 31u), (32u - vertex_unnamed_22))));
				float vertex_unnamed_35 = float((uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) & 2u);
				gl_Position.x = mad(vertex_unnamed_34, 2.0f, -1.0f);
				gl_Position.y = mad(vertex_unnamed_35, 2.0f, -1.0f);
				vertex_output_1.x = vertex_unnamed_34;
				vertex_output_1.y = ((-0.0f) - vertex_unnamed_35) + 1.0f;
				gl_Position.z = 1.0f;
				gl_Position.w = 1.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				gl_VertexIndex = int(stage_input.gl_VertexIndex + 0u);
				gl_BaseVertexARB = 0u;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float _Strength;
			float _Distance;
			float _Speed;
			float2 _Size;
			float4 _RTHandleScale;
			float4 _Time;

			static float4 fragment_uniform_buffer_0[2];
			static float4 fragment_uniform_buffer_1[77];
			Texture2DArray<float4> _MainTex;
			SamplerState sampler_linear_clamp_S0;

			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_51 = (((-0.0f) - fragment_input_1.x) + 0.5f) * fragment_uniform_buffer_0[1u].x;
				float fragment_unnamed_52 = (((-0.0f) - fragment_input_1.y) + 0.5f) * fragment_uniform_buffer_0[1u].y;
				float fragment_unnamed_74 = sin(mad(fragment_uniform_buffer_1[76u].x, fragment_uniform_buffer_0[0u].z, (-0.0f) - ((fragment_unnamed_52 * fragment_unnamed_52) + (fragment_unnamed_51 * fragment_unnamed_51))) / fragment_uniform_buffer_0[0u].y) * fragment_uniform_buffer_0[0u].x;
				float4 fragment_unnamed_92 = _MainTex.Sample(sampler_linear_clamp_S0, float3(mad(fragment_unnamed_74, 0.5f, fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, mad(fragment_unnamed_74, 0.5f, fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				fragment_output_0.x = fragment_unnamed_92.x;
				fragment_output_0.y = fragment_unnamed_92.y;
				fragment_output_0.z = fragment_unnamed_92.z;
				fragment_output_0.w = fragment_unnamed_92.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Strength, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], _Distance, fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], fragment_uniform_buffer_0[0][1], _Speed, fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[1] = float4(_Size[0], _Size[1], fragment_uniform_buffer_0[1][2], fragment_uniform_buffer_0[1][3]);

				fragment_uniform_buffer_1[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

				fragment_uniform_buffer_1[76] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}



			#endif
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			#define RIP_HAS_VERT
			static float4 gl_Position;
			static int gl_VertexIndex;
			static int gl_BaseVertexARB;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				uint gl_VertexIndex : SV_VertexID;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 gl_Position : SV_Position;
			};

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

			void vert_main()
			{
				uint vertex_unnamed_22 = 1u & 31u;
				float vertex_unnamed_34 = float(spvBitfieldInsert(0u, uint(gl_VertexIndex) - uint(gl_BaseVertexARB), vertex_unnamed_22, min((1u & 31u), (32u - vertex_unnamed_22))));
				float vertex_unnamed_35 = float((uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) & 2u);
				gl_Position.x = mad(vertex_unnamed_34, 2.0f, -1.0f);
				gl_Position.y = mad(vertex_unnamed_35, 2.0f, -1.0f);
				vertex_output_1.x = vertex_unnamed_34;
				vertex_output_1.y = ((-0.0f) - vertex_unnamed_35) + 1.0f;
				gl_Position.z = 1.0f;
				gl_Position.w = 1.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				gl_VertexIndex = int(stage_input.gl_VertexIndex + 0u);
				gl_BaseVertexARB = 0u;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			#define RIP_HAS_FRAG


			float _Strength;
			float _Distance;
			float _Speed;
			float2 _Size;
			float4 _RTHandleScale;
			float4 _Time;

			static float4 fragment_uniform_buffer_0[2];
			static float4 fragment_uniform_buffer_1[77];
			Texture2DArray<float4> _MainTex;
			SamplerState sampler_linear_clamp_S0;

			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_51 = (((-0.0f) - fragment_input_1.x) + 0.5f) * fragment_uniform_buffer_0[1u].x;
				float fragment_unnamed_52 = (((-0.0f) - fragment_input_1.y) + 0.5f) * fragment_uniform_buffer_0[1u].y;
				float fragment_unnamed_74 = sin(mad(fragment_uniform_buffer_1[76u].x, fragment_uniform_buffer_0[0u].z, (-0.0f) - ((fragment_unnamed_52 * fragment_unnamed_52) + (fragment_unnamed_51 * fragment_unnamed_51))) / fragment_uniform_buffer_0[0u].y) * fragment_uniform_buffer_0[0u].x;
				float4 fragment_unnamed_92 = _MainTex.Sample(sampler_linear_clamp_S0, float3(mad(fragment_unnamed_74, 0.5f, fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, mad(fragment_unnamed_74, 0.5f, fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				fragment_output_0.x = fragment_unnamed_92.x;
				fragment_output_0.y = fragment_unnamed_92.y;
				fragment_output_0.z = fragment_unnamed_92.z;
				fragment_output_0.w = fragment_unnamed_92.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Strength, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], _Distance, fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], fragment_uniform_buffer_0[0][1], _Speed, fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[1] = float4(_Size[0], _Size[1], fragment_uniform_buffer_0[1][2], fragment_uniform_buffer_0[1][3]);

				fragment_uniform_buffer_1[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

				fragment_uniform_buffer_1[76] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_input_1 = stage_input.fragment_input_1;
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
			Name "Ripples: Omnidirectional"
			Tags { "RenderPipeline" = "HDRenderPipeline" }
			ZTest Always
			ZWrite Off
			Cull Off
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 99107

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			#if defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT
			static float4 gl_Position;
			static int gl_VertexIndex;
			static int gl_BaseVertexARB;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				uint gl_VertexIndex : SV_VertexID;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 gl_Position : SV_Position;
			};

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

			void vert_main()
			{
				uint vertex_unnamed_22 = 1u & 31u;
				float vertex_unnamed_34 = float(spvBitfieldInsert(0u, uint(gl_VertexIndex) - uint(gl_BaseVertexARB), vertex_unnamed_22, min((1u & 31u), (32u - vertex_unnamed_22))));
				float vertex_unnamed_35 = float((uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) & 2u);
				gl_Position.x = mad(vertex_unnamed_34, 2.0f, -1.0f);
				gl_Position.y = mad(vertex_unnamed_35, 2.0f, -1.0f);
				vertex_output_1.x = vertex_unnamed_34;
				vertex_output_1.y = ((-0.0f) - vertex_unnamed_35) + 1.0f;
				gl_Position.z = 1.0f;
				gl_Position.w = 1.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				gl_VertexIndex = int(stage_input.gl_VertexIndex + 0u);
				gl_BaseVertexARB = 0u;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float _Strength;
			float _Distance;
			float _Speed;
			float4 _RTHandleScale;
			float4 _Time;

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[77];
			Texture2DArray<float4> _MainTex;
			SamplerState sampler_linear_clamp_S0;

			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_41 = fragment_uniform_buffer_0[0u].y * 100.0f;
				float fragment_unnamed_48 = fragment_unnamed_41 * fragment_input_1.x;
				float fragment_unnamed_49 = fragment_unnamed_41 * fragment_input_1.y;
				float fragment_unnamed_58 = (fragment_uniform_buffer_0[0u].z * fragment_uniform_buffer_1[76u].y) * 0.25f;
				float fragment_unnamed_60 = dot(float3(fragment_unnamed_48, fragment_unnamed_49, fragment_unnamed_58), 0.3333333432674407958984375f.xxx);
				float fragment_unnamed_69 = floor(fragment_unnamed_60 + fragment_unnamed_48);
				float fragment_unnamed_70 = floor(fragment_unnamed_60 + fragment_unnamed_49);
				float fragment_unnamed_71 = floor(fragment_unnamed_60 + fragment_unnamed_58);
				float fragment_unnamed_83 = mad((-0.0f) - floor(fragment_unnamed_69 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_69);
				float fragment_unnamed_85 = mad((-0.0f) - floor(fragment_unnamed_70 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_70);
				float fragment_unnamed_86 = mad((-0.0f) - floor(fragment_unnamed_71 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_71);
				float fragment_unnamed_93 = dot(float3(fragment_unnamed_69, fragment_unnamed_70, fragment_unnamed_71), 0.16666667163372039794921875f.xxx);
				float fragment_unnamed_97 = fragment_unnamed_93 + (fragment_unnamed_48 + ((-0.0f) - fragment_unnamed_69));
				float fragment_unnamed_98 = fragment_unnamed_93 + (fragment_unnamed_49 + ((-0.0f) - fragment_unnamed_70));
				float fragment_unnamed_99 = fragment_unnamed_93 + (fragment_unnamed_58 + ((-0.0f) - fragment_unnamed_71));
				bool fragment_unnamed_101 = fragment_unnamed_99 >= fragment_unnamed_97;
				bool fragment_unnamed_102 = fragment_unnamed_97 >= fragment_unnamed_98;
				bool fragment_unnamed_103 = fragment_unnamed_98 >= fragment_unnamed_99;
				float fragment_unnamed_109 = asfloat((fragment_unnamed_102 ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_111 = asfloat((fragment_unnamed_103 ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_113 = asfloat((fragment_unnamed_101 ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_115 = asfloat(fragment_unnamed_101 ? 0u : 1065353216u);
				float fragment_unnamed_117 = asfloat(fragment_unnamed_102 ? 0u : 1065353216u);
				float fragment_unnamed_119 = asfloat(fragment_unnamed_103 ? 0u : 1065353216u);
				float fragment_unnamed_120 = min(fragment_unnamed_115, fragment_unnamed_109);
				float fragment_unnamed_121 = min(fragment_unnamed_117, fragment_unnamed_111);
				float fragment_unnamed_122 = min(fragment_unnamed_119, fragment_unnamed_113);
				float fragment_unnamed_123 = max(fragment_unnamed_115, fragment_unnamed_109);
				float fragment_unnamed_124 = max(fragment_unnamed_117, fragment_unnamed_111);
				float fragment_unnamed_125 = max(fragment_unnamed_119, fragment_unnamed_113);
				float fragment_unnamed_126 = asfloat(0u) + fragment_unnamed_86;
				float fragment_unnamed_127 = fragment_unnamed_122 + fragment_unnamed_86;
				float fragment_unnamed_128 = fragment_unnamed_125 + fragment_unnamed_86;
				float fragment_unnamed_129 = asfloat(1065353216u) + fragment_unnamed_86;
				float fragment_unnamed_136 = fragment_unnamed_126 * mad(fragment_unnamed_126, 34.0f, 1.0f);
				float fragment_unnamed_137 = fragment_unnamed_127 * mad(fragment_unnamed_127, 34.0f, 1.0f);
				float fragment_unnamed_138 = fragment_unnamed_128 * mad(fragment_unnamed_128, 34.0f, 1.0f);
				float fragment_unnamed_139 = fragment_unnamed_129 * mad(fragment_unnamed_129, 34.0f, 1.0f);
				float fragment_unnamed_162 = (fragment_unnamed_85 + mad((-0.0f) - floor(fragment_unnamed_136 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_136)) + asfloat(0u);
				float fragment_unnamed_163 = (fragment_unnamed_85 + mad((-0.0f) - floor(fragment_unnamed_137 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_137)) + fragment_unnamed_121;
				float fragment_unnamed_164 = (fragment_unnamed_85 + mad((-0.0f) - floor(fragment_unnamed_138 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_138)) + fragment_unnamed_124;
				float fragment_unnamed_165 = (fragment_unnamed_85 + mad((-0.0f) - floor(fragment_unnamed_139 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_139)) + asfloat(1065353216u);
				float fragment_unnamed_170 = fragment_unnamed_162 * mad(fragment_unnamed_162, 34.0f, 1.0f);
				float fragment_unnamed_171 = fragment_unnamed_163 * mad(fragment_unnamed_163, 34.0f, 1.0f);
				float fragment_unnamed_172 = fragment_unnamed_164 * mad(fragment_unnamed_164, 34.0f, 1.0f);
				float fragment_unnamed_173 = fragment_unnamed_165 * mad(fragment_unnamed_165, 34.0f, 1.0f);
				float fragment_unnamed_202 = (fragment_unnamed_97 + ((-0.0f) - fragment_unnamed_120)) + 0.16666667163372039794921875f;
				float fragment_unnamed_203 = (fragment_unnamed_98 + ((-0.0f) - fragment_unnamed_121)) + 0.16666667163372039794921875f;
				float fragment_unnamed_204 = (fragment_unnamed_99 + ((-0.0f) - fragment_unnamed_122)) + 0.16666667163372039794921875f;
				float fragment_unnamed_211 = (fragment_unnamed_97 + ((-0.0f) - fragment_unnamed_123)) + 0.3333333432674407958984375f;
				float fragment_unnamed_212 = (fragment_unnamed_98 + ((-0.0f) - fragment_unnamed_124)) + 0.3333333432674407958984375f;
				float fragment_unnamed_213 = (fragment_unnamed_99 + ((-0.0f) - fragment_unnamed_125)) + 0.3333333432674407958984375f;
				float fragment_unnamed_214 = (fragment_unnamed_83 + mad((-0.0f) - floor(fragment_unnamed_170 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_170)) + asfloat(0u);
				float fragment_unnamed_215 = (fragment_unnamed_83 + mad((-0.0f) - floor(fragment_unnamed_171 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_171)) + fragment_unnamed_120;
				float fragment_unnamed_216 = (fragment_unnamed_83 + mad((-0.0f) - floor(fragment_unnamed_172 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_172)) + fragment_unnamed_123;
				float fragment_unnamed_217 = (fragment_unnamed_83 + mad((-0.0f) - floor(fragment_unnamed_173 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_173)) + asfloat(1065353216u);
				float fragment_unnamed_222 = fragment_unnamed_214 * mad(fragment_unnamed_214, 34.0f, 1.0f);
				float fragment_unnamed_223 = fragment_unnamed_215 * mad(fragment_unnamed_215, 34.0f, 1.0f);
				float fragment_unnamed_224 = fragment_unnamed_216 * mad(fragment_unnamed_216, 34.0f, 1.0f);
				float fragment_unnamed_225 = fragment_unnamed_217 * mad(fragment_unnamed_217, 34.0f, 1.0f);
				float fragment_unnamed_238 = mad((-0.0f) - floor(fragment_unnamed_222 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_222);
				float fragment_unnamed_239 = mad((-0.0f) - floor(fragment_unnamed_223 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_223);
				float fragment_unnamed_240 = mad((-0.0f) - floor(fragment_unnamed_224 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_224);
				float fragment_unnamed_241 = mad((-0.0f) - floor(fragment_unnamed_225 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_225);
				float fragment_unnamed_255 = mad((-0.0f) - floor(fragment_unnamed_238 * 0.02040816284716129302978515625f), 49.0f, fragment_unnamed_238);
				float fragment_unnamed_257 = mad((-0.0f) - floor(fragment_unnamed_239 * 0.02040816284716129302978515625f), 49.0f, fragment_unnamed_239);
				float fragment_unnamed_258 = mad((-0.0f) - floor(fragment_unnamed_240 * 0.02040816284716129302978515625f), 49.0f, fragment_unnamed_240);
				float fragment_unnamed_259 = mad((-0.0f) - floor(fragment_unnamed_241 * 0.02040816284716129302978515625f), 49.0f, fragment_unnamed_241);
				float fragment_unnamed_265 = floor(fragment_unnamed_255 * 0.14285714924335479736328125f);
				float fragment_unnamed_266 = floor(fragment_unnamed_257 * 0.14285714924335479736328125f);
				float fragment_unnamed_267 = floor(fragment_unnamed_258 * 0.14285714924335479736328125f);
				float fragment_unnamed_268 = floor(fragment_unnamed_259 * 0.14285714924335479736328125f);
				float fragment_unnamed_278 = mad(fragment_unnamed_267, 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_281 = mad(fragment_unnamed_265, 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_282 = mad(fragment_unnamed_268, 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_283 = mad(fragment_unnamed_266, 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_284 = mad(mad((-0.0f) - fragment_unnamed_265, 7.0f, fragment_unnamed_255), 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_285 = mad(mad((-0.0f) - fragment_unnamed_266, 7.0f, fragment_unnamed_257), 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_286 = mad(mad((-0.0f) - fragment_unnamed_267, 7.0f, fragment_unnamed_258), 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_287 = mad(mad((-0.0f) - fragment_unnamed_268, 7.0f, fragment_unnamed_259), 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_317 = ((-0.0f) - abs(fragment_unnamed_284)) + (((-0.0f) - abs(fragment_unnamed_281)) + 1.0f);
				float fragment_unnamed_318 = ((-0.0f) - abs(fragment_unnamed_285)) + (((-0.0f) - abs(fragment_unnamed_283)) + 1.0f);
				float fragment_unnamed_319 = ((-0.0f) - abs(fragment_unnamed_287)) + (((-0.0f) - abs(fragment_unnamed_282)) + 1.0f);
				float fragment_unnamed_320 = ((-0.0f) - abs(fragment_unnamed_286)) + (((-0.0f) - abs(fragment_unnamed_278)) + 1.0f);
				float fragment_unnamed_332 = asfloat((0.0f >= fragment_unnamed_318) ? 3212836864u : 2147483648u);
				float fragment_unnamed_333 = asfloat((0.0f >= fragment_unnamed_317) ? 3212836864u : 2147483648u);
				float fragment_unnamed_334 = mad(mad(floor(fragment_unnamed_283), 2.0f, 1.0f), fragment_unnamed_332, fragment_unnamed_283);
				float fragment_unnamed_335 = mad(mad(floor(fragment_unnamed_285), 2.0f, 1.0f), fragment_unnamed_332, fragment_unnamed_285);
				float fragment_unnamed_336 = mad(mad(floor(fragment_unnamed_281), 2.0f, 1.0f), fragment_unnamed_333, fragment_unnamed_281);
				float fragment_unnamed_337 = mad(mad(floor(fragment_unnamed_284), 2.0f, 1.0f), fragment_unnamed_333, fragment_unnamed_284);
				float fragment_unnamed_352 = asfloat((0.0f >= fragment_unnamed_320) ? 3212836864u : 2147483648u);
				float fragment_unnamed_353 = asfloat((0.0f >= fragment_unnamed_319) ? 3212836864u : 2147483648u);
				float fragment_unnamed_354 = mad(mad(floor(fragment_unnamed_278), 2.0f, 1.0f), fragment_unnamed_352, fragment_unnamed_278);
				float fragment_unnamed_355 = mad(mad(floor(fragment_unnamed_286), 2.0f, 1.0f), fragment_unnamed_352, fragment_unnamed_286);
				float fragment_unnamed_356 = mad(mad(floor(fragment_unnamed_282), 2.0f, 1.0f), fragment_unnamed_353, fragment_unnamed_282);
				float fragment_unnamed_357 = mad(mad(floor(fragment_unnamed_287), 2.0f, 1.0f), fragment_unnamed_353, fragment_unnamed_287);
				float fragment_unnamed_368 = mad((-0.0f) - dot(float3(fragment_unnamed_336, fragment_unnamed_337, fragment_unnamed_317), float3(fragment_unnamed_336, fragment_unnamed_337, fragment_unnamed_317)), 0.8537347316741943359375f, 1.792842864990234375f);
				float fragment_unnamed_371 = mad((-0.0f) - dot(float3(fragment_unnamed_334, fragment_unnamed_335, fragment_unnamed_318), float3(fragment_unnamed_334, fragment_unnamed_335, fragment_unnamed_318)), 0.8537347316741943359375f, 1.792842864990234375f);
				float fragment_unnamed_372 = mad((-0.0f) - dot(float3(fragment_unnamed_354, fragment_unnamed_355, fragment_unnamed_320), float3(fragment_unnamed_354, fragment_unnamed_355, fragment_unnamed_320)), 0.8537347316741943359375f, 1.792842864990234375f);
				float fragment_unnamed_373 = mad((-0.0f) - dot(float3(fragment_unnamed_356, fragment_unnamed_357, fragment_unnamed_319), float3(fragment_unnamed_356, fragment_unnamed_357, fragment_unnamed_319)), 0.8537347316741943359375f, 1.792842864990234375f);
				float fragment_unnamed_401 = fragment_unnamed_97 + (-0.5f);
				float fragment_unnamed_403 = fragment_unnamed_98 + (-0.5f);
				float fragment_unnamed_404 = fragment_unnamed_99 + (-0.5f);
				float fragment_unnamed_423 = max(((-0.0f) - dot(float3(fragment_unnamed_97, fragment_unnamed_98, fragment_unnamed_99), float3(fragment_unnamed_97, fragment_unnamed_98, fragment_unnamed_99))) + 0.60000002384185791015625f, 0.0f);
				float fragment_unnamed_424 = max(((-0.0f) - dot(float3(fragment_unnamed_202, fragment_unnamed_203, fragment_unnamed_204), float3(fragment_unnamed_202, fragment_unnamed_203, fragment_unnamed_204))) + 0.60000002384185791015625f, 0.0f);
				float fragment_unnamed_425 = max(((-0.0f) - dot(float3(fragment_unnamed_211, fragment_unnamed_212, fragment_unnamed_213), float3(fragment_unnamed_211, fragment_unnamed_212, fragment_unnamed_213))) + 0.60000002384185791015625f, 0.0f);
				float fragment_unnamed_426 = max(((-0.0f) - dot(float3(fragment_unnamed_401, fragment_unnamed_403, fragment_unnamed_404), float3(fragment_unnamed_401, fragment_unnamed_403, fragment_unnamed_404))) + 0.60000002384185791015625f, 0.0f);
				float fragment_unnamed_427 = fragment_unnamed_423 * fragment_unnamed_423;
				float fragment_unnamed_428 = fragment_unnamed_424 * fragment_unnamed_424;
				float fragment_unnamed_429 = fragment_unnamed_425 * fragment_unnamed_425;
				float fragment_unnamed_430 = fragment_unnamed_426 * fragment_unnamed_426;
				float fragment_unnamed_438 = mad(dot(float4(fragment_unnamed_427 * fragment_unnamed_427, fragment_unnamed_428 * fragment_unnamed_428, fragment_unnamed_429 * fragment_unnamed_429, fragment_unnamed_430 * fragment_unnamed_430), float4(dot(float3(fragment_unnamed_97, fragment_unnamed_98, fragment_unnamed_99), float3(fragment_unnamed_368 * fragment_unnamed_336, fragment_unnamed_368 * fragment_unnamed_337, fragment_unnamed_368 * fragment_unnamed_317)), dot(float3(fragment_unnamed_202, fragment_unnamed_203, fragment_unnamed_204), float3(fragment_unnamed_371 * fragment_unnamed_334, fragment_unnamed_371 * fragment_unnamed_335, fragment_unnamed_371 * fragment_unnamed_318)), dot(float3(fragment_unnamed_211, fragment_unnamed_212, fragment_unnamed_213), float3(fragment_unnamed_354 * fragment_unnamed_372, fragment_unnamed_355 * fragment_unnamed_372, fragment_unnamed_320 * fragment_unnamed_372)), dot(float3(fragment_unnamed_401, fragment_unnamed_403, fragment_unnamed_404), float3(fragment_unnamed_373 * fragment_unnamed_356, fragment_unnamed_373 * fragment_unnamed_357, fragment_unnamed_373 * fragment_unnamed_319)))), 21.0f, 0.5f);
				float4 fragment_unnamed_460 = _MainTex.Sample(sampler_linear_clamp_S0, float3(mad(fragment_unnamed_438, fragment_uniform_buffer_0[0u].x, fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, mad(fragment_unnamed_438, fragment_uniform_buffer_0[0u].x, fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				fragment_output_0.x = fragment_unnamed_460.x;
				fragment_output_0.y = fragment_unnamed_460.y;
				fragment_output_0.z = fragment_unnamed_460.z;
				fragment_output_0.w = fragment_unnamed_460.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Strength, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], _Distance, fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], fragment_uniform_buffer_0[0][1], _Speed, fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_1[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

				fragment_uniform_buffer_1[76] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}



			#endif
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			#define RIP_HAS_VERT
			static float4 gl_Position;
			static int gl_VertexIndex;
			static int gl_BaseVertexARB;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				uint gl_VertexIndex : SV_VertexID;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 gl_Position : SV_Position;
			};

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

			void vert_main()
			{
				uint vertex_unnamed_22 = 1u & 31u;
				float vertex_unnamed_34 = float(spvBitfieldInsert(0u, uint(gl_VertexIndex) - uint(gl_BaseVertexARB), vertex_unnamed_22, min((1u & 31u), (32u - vertex_unnamed_22))));
				float vertex_unnamed_35 = float((uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) & 2u);
				gl_Position.x = mad(vertex_unnamed_34, 2.0f, -1.0f);
				gl_Position.y = mad(vertex_unnamed_35, 2.0f, -1.0f);
				vertex_output_1.x = vertex_unnamed_34;
				vertex_output_1.y = ((-0.0f) - vertex_unnamed_35) + 1.0f;
				gl_Position.z = 1.0f;
				gl_Position.w = 1.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				gl_VertexIndex = int(stage_input.gl_VertexIndex + 0u);
				gl_BaseVertexARB = 0u;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			#define RIP_HAS_FRAG


			float _Strength;
			float _Distance;
			float _Speed;
			float4 _RTHandleScale;
			float4 _Time;

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[77];
			Texture2DArray<float4> _MainTex;
			SamplerState sampler_linear_clamp_S0;

			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_41 = fragment_uniform_buffer_0[0u].y * 100.0f;
				float fragment_unnamed_48 = fragment_unnamed_41 * fragment_input_1.x;
				float fragment_unnamed_49 = fragment_unnamed_41 * fragment_input_1.y;
				float fragment_unnamed_58 = (fragment_uniform_buffer_0[0u].z * fragment_uniform_buffer_1[76u].y) * 0.25f;
				float fragment_unnamed_60 = dot(float3(fragment_unnamed_48, fragment_unnamed_49, fragment_unnamed_58), 0.3333333432674407958984375f.xxx);
				float fragment_unnamed_69 = floor(fragment_unnamed_60 + fragment_unnamed_48);
				float fragment_unnamed_70 = floor(fragment_unnamed_60 + fragment_unnamed_49);
				float fragment_unnamed_71 = floor(fragment_unnamed_60 + fragment_unnamed_58);
				float fragment_unnamed_83 = mad((-0.0f) - floor(fragment_unnamed_69 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_69);
				float fragment_unnamed_85 = mad((-0.0f) - floor(fragment_unnamed_70 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_70);
				float fragment_unnamed_86 = mad((-0.0f) - floor(fragment_unnamed_71 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_71);
				float fragment_unnamed_93 = dot(float3(fragment_unnamed_69, fragment_unnamed_70, fragment_unnamed_71), 0.16666667163372039794921875f.xxx);
				float fragment_unnamed_97 = fragment_unnamed_93 + (fragment_unnamed_48 + ((-0.0f) - fragment_unnamed_69));
				float fragment_unnamed_98 = fragment_unnamed_93 + (fragment_unnamed_49 + ((-0.0f) - fragment_unnamed_70));
				float fragment_unnamed_99 = fragment_unnamed_93 + (fragment_unnamed_58 + ((-0.0f) - fragment_unnamed_71));
				bool fragment_unnamed_101 = fragment_unnamed_99 >= fragment_unnamed_97;
				bool fragment_unnamed_102 = fragment_unnamed_97 >= fragment_unnamed_98;
				bool fragment_unnamed_103 = fragment_unnamed_98 >= fragment_unnamed_99;
				float fragment_unnamed_109 = asfloat((fragment_unnamed_102 ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_111 = asfloat((fragment_unnamed_103 ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_113 = asfloat((fragment_unnamed_101 ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_115 = asfloat(fragment_unnamed_101 ? 0u : 1065353216u);
				float fragment_unnamed_117 = asfloat(fragment_unnamed_102 ? 0u : 1065353216u);
				float fragment_unnamed_119 = asfloat(fragment_unnamed_103 ? 0u : 1065353216u);
				float fragment_unnamed_120 = min(fragment_unnamed_115, fragment_unnamed_109);
				float fragment_unnamed_121 = min(fragment_unnamed_117, fragment_unnamed_111);
				float fragment_unnamed_122 = min(fragment_unnamed_119, fragment_unnamed_113);
				float fragment_unnamed_123 = max(fragment_unnamed_115, fragment_unnamed_109);
				float fragment_unnamed_124 = max(fragment_unnamed_117, fragment_unnamed_111);
				float fragment_unnamed_125 = max(fragment_unnamed_119, fragment_unnamed_113);
				float fragment_unnamed_126 = asfloat(0u) + fragment_unnamed_86;
				float fragment_unnamed_127 = fragment_unnamed_122 + fragment_unnamed_86;
				float fragment_unnamed_128 = fragment_unnamed_125 + fragment_unnamed_86;
				float fragment_unnamed_129 = asfloat(1065353216u) + fragment_unnamed_86;
				float fragment_unnamed_136 = fragment_unnamed_126 * mad(fragment_unnamed_126, 34.0f, 1.0f);
				float fragment_unnamed_137 = fragment_unnamed_127 * mad(fragment_unnamed_127, 34.0f, 1.0f);
				float fragment_unnamed_138 = fragment_unnamed_128 * mad(fragment_unnamed_128, 34.0f, 1.0f);
				float fragment_unnamed_139 = fragment_unnamed_129 * mad(fragment_unnamed_129, 34.0f, 1.0f);
				float fragment_unnamed_162 = (fragment_unnamed_85 + mad((-0.0f) - floor(fragment_unnamed_136 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_136)) + asfloat(0u);
				float fragment_unnamed_163 = (fragment_unnamed_85 + mad((-0.0f) - floor(fragment_unnamed_137 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_137)) + fragment_unnamed_121;
				float fragment_unnamed_164 = (fragment_unnamed_85 + mad((-0.0f) - floor(fragment_unnamed_138 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_138)) + fragment_unnamed_124;
				float fragment_unnamed_165 = (fragment_unnamed_85 + mad((-0.0f) - floor(fragment_unnamed_139 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_139)) + asfloat(1065353216u);
				float fragment_unnamed_170 = fragment_unnamed_162 * mad(fragment_unnamed_162, 34.0f, 1.0f);
				float fragment_unnamed_171 = fragment_unnamed_163 * mad(fragment_unnamed_163, 34.0f, 1.0f);
				float fragment_unnamed_172 = fragment_unnamed_164 * mad(fragment_unnamed_164, 34.0f, 1.0f);
				float fragment_unnamed_173 = fragment_unnamed_165 * mad(fragment_unnamed_165, 34.0f, 1.0f);
				float fragment_unnamed_202 = (fragment_unnamed_97 + ((-0.0f) - fragment_unnamed_120)) + 0.16666667163372039794921875f;
				float fragment_unnamed_203 = (fragment_unnamed_98 + ((-0.0f) - fragment_unnamed_121)) + 0.16666667163372039794921875f;
				float fragment_unnamed_204 = (fragment_unnamed_99 + ((-0.0f) - fragment_unnamed_122)) + 0.16666667163372039794921875f;
				float fragment_unnamed_211 = (fragment_unnamed_97 + ((-0.0f) - fragment_unnamed_123)) + 0.3333333432674407958984375f;
				float fragment_unnamed_212 = (fragment_unnamed_98 + ((-0.0f) - fragment_unnamed_124)) + 0.3333333432674407958984375f;
				float fragment_unnamed_213 = (fragment_unnamed_99 + ((-0.0f) - fragment_unnamed_125)) + 0.3333333432674407958984375f;
				float fragment_unnamed_214 = (fragment_unnamed_83 + mad((-0.0f) - floor(fragment_unnamed_170 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_170)) + asfloat(0u);
				float fragment_unnamed_215 = (fragment_unnamed_83 + mad((-0.0f) - floor(fragment_unnamed_171 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_171)) + fragment_unnamed_120;
				float fragment_unnamed_216 = (fragment_unnamed_83 + mad((-0.0f) - floor(fragment_unnamed_172 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_172)) + fragment_unnamed_123;
				float fragment_unnamed_217 = (fragment_unnamed_83 + mad((-0.0f) - floor(fragment_unnamed_173 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_173)) + asfloat(1065353216u);
				float fragment_unnamed_222 = fragment_unnamed_214 * mad(fragment_unnamed_214, 34.0f, 1.0f);
				float fragment_unnamed_223 = fragment_unnamed_215 * mad(fragment_unnamed_215, 34.0f, 1.0f);
				float fragment_unnamed_224 = fragment_unnamed_216 * mad(fragment_unnamed_216, 34.0f, 1.0f);
				float fragment_unnamed_225 = fragment_unnamed_217 * mad(fragment_unnamed_217, 34.0f, 1.0f);
				float fragment_unnamed_238 = mad((-0.0f) - floor(fragment_unnamed_222 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_222);
				float fragment_unnamed_239 = mad((-0.0f) - floor(fragment_unnamed_223 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_223);
				float fragment_unnamed_240 = mad((-0.0f) - floor(fragment_unnamed_224 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_224);
				float fragment_unnamed_241 = mad((-0.0f) - floor(fragment_unnamed_225 * 0.00346020772121846675872802734375f), 289.0f, fragment_unnamed_225);
				float fragment_unnamed_255 = mad((-0.0f) - floor(fragment_unnamed_238 * 0.02040816284716129302978515625f), 49.0f, fragment_unnamed_238);
				float fragment_unnamed_257 = mad((-0.0f) - floor(fragment_unnamed_239 * 0.02040816284716129302978515625f), 49.0f, fragment_unnamed_239);
				float fragment_unnamed_258 = mad((-0.0f) - floor(fragment_unnamed_240 * 0.02040816284716129302978515625f), 49.0f, fragment_unnamed_240);
				float fragment_unnamed_259 = mad((-0.0f) - floor(fragment_unnamed_241 * 0.02040816284716129302978515625f), 49.0f, fragment_unnamed_241);
				float fragment_unnamed_265 = floor(fragment_unnamed_255 * 0.14285714924335479736328125f);
				float fragment_unnamed_266 = floor(fragment_unnamed_257 * 0.14285714924335479736328125f);
				float fragment_unnamed_267 = floor(fragment_unnamed_258 * 0.14285714924335479736328125f);
				float fragment_unnamed_268 = floor(fragment_unnamed_259 * 0.14285714924335479736328125f);
				float fragment_unnamed_278 = mad(fragment_unnamed_267, 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_281 = mad(fragment_unnamed_265, 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_282 = mad(fragment_unnamed_268, 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_283 = mad(fragment_unnamed_266, 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_284 = mad(mad((-0.0f) - fragment_unnamed_265, 7.0f, fragment_unnamed_255), 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_285 = mad(mad((-0.0f) - fragment_unnamed_266, 7.0f, fragment_unnamed_257), 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_286 = mad(mad((-0.0f) - fragment_unnamed_267, 7.0f, fragment_unnamed_258), 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_287 = mad(mad((-0.0f) - fragment_unnamed_268, 7.0f, fragment_unnamed_259), 0.2857142984867095947265625f, -0.928571403026580810546875f);
				float fragment_unnamed_317 = ((-0.0f) - abs(fragment_unnamed_284)) + (((-0.0f) - abs(fragment_unnamed_281)) + 1.0f);
				float fragment_unnamed_318 = ((-0.0f) - abs(fragment_unnamed_285)) + (((-0.0f) - abs(fragment_unnamed_283)) + 1.0f);
				float fragment_unnamed_319 = ((-0.0f) - abs(fragment_unnamed_287)) + (((-0.0f) - abs(fragment_unnamed_282)) + 1.0f);
				float fragment_unnamed_320 = ((-0.0f) - abs(fragment_unnamed_286)) + (((-0.0f) - abs(fragment_unnamed_278)) + 1.0f);
				float fragment_unnamed_332 = asfloat((0.0f >= fragment_unnamed_318) ? 3212836864u : 2147483648u);
				float fragment_unnamed_333 = asfloat((0.0f >= fragment_unnamed_317) ? 3212836864u : 2147483648u);
				float fragment_unnamed_334 = mad(mad(floor(fragment_unnamed_283), 2.0f, 1.0f), fragment_unnamed_332, fragment_unnamed_283);
				float fragment_unnamed_335 = mad(mad(floor(fragment_unnamed_285), 2.0f, 1.0f), fragment_unnamed_332, fragment_unnamed_285);
				float fragment_unnamed_336 = mad(mad(floor(fragment_unnamed_281), 2.0f, 1.0f), fragment_unnamed_333, fragment_unnamed_281);
				float fragment_unnamed_337 = mad(mad(floor(fragment_unnamed_284), 2.0f, 1.0f), fragment_unnamed_333, fragment_unnamed_284);
				float fragment_unnamed_352 = asfloat((0.0f >= fragment_unnamed_320) ? 3212836864u : 2147483648u);
				float fragment_unnamed_353 = asfloat((0.0f >= fragment_unnamed_319) ? 3212836864u : 2147483648u);
				float fragment_unnamed_354 = mad(mad(floor(fragment_unnamed_278), 2.0f, 1.0f), fragment_unnamed_352, fragment_unnamed_278);
				float fragment_unnamed_355 = mad(mad(floor(fragment_unnamed_286), 2.0f, 1.0f), fragment_unnamed_352, fragment_unnamed_286);
				float fragment_unnamed_356 = mad(mad(floor(fragment_unnamed_282), 2.0f, 1.0f), fragment_unnamed_353, fragment_unnamed_282);
				float fragment_unnamed_357 = mad(mad(floor(fragment_unnamed_287), 2.0f, 1.0f), fragment_unnamed_353, fragment_unnamed_287);
				float fragment_unnamed_368 = mad((-0.0f) - dot(float3(fragment_unnamed_336, fragment_unnamed_337, fragment_unnamed_317), float3(fragment_unnamed_336, fragment_unnamed_337, fragment_unnamed_317)), 0.8537347316741943359375f, 1.792842864990234375f);
				float fragment_unnamed_371 = mad((-0.0f) - dot(float3(fragment_unnamed_334, fragment_unnamed_335, fragment_unnamed_318), float3(fragment_unnamed_334, fragment_unnamed_335, fragment_unnamed_318)), 0.8537347316741943359375f, 1.792842864990234375f);
				float fragment_unnamed_372 = mad((-0.0f) - dot(float3(fragment_unnamed_354, fragment_unnamed_355, fragment_unnamed_320), float3(fragment_unnamed_354, fragment_unnamed_355, fragment_unnamed_320)), 0.8537347316741943359375f, 1.792842864990234375f);
				float fragment_unnamed_373 = mad((-0.0f) - dot(float3(fragment_unnamed_356, fragment_unnamed_357, fragment_unnamed_319), float3(fragment_unnamed_356, fragment_unnamed_357, fragment_unnamed_319)), 0.8537347316741943359375f, 1.792842864990234375f);
				float fragment_unnamed_401 = fragment_unnamed_97 + (-0.5f);
				float fragment_unnamed_403 = fragment_unnamed_98 + (-0.5f);
				float fragment_unnamed_404 = fragment_unnamed_99 + (-0.5f);
				float fragment_unnamed_423 = max(((-0.0f) - dot(float3(fragment_unnamed_97, fragment_unnamed_98, fragment_unnamed_99), float3(fragment_unnamed_97, fragment_unnamed_98, fragment_unnamed_99))) + 0.60000002384185791015625f, 0.0f);
				float fragment_unnamed_424 = max(((-0.0f) - dot(float3(fragment_unnamed_202, fragment_unnamed_203, fragment_unnamed_204), float3(fragment_unnamed_202, fragment_unnamed_203, fragment_unnamed_204))) + 0.60000002384185791015625f, 0.0f);
				float fragment_unnamed_425 = max(((-0.0f) - dot(float3(fragment_unnamed_211, fragment_unnamed_212, fragment_unnamed_213), float3(fragment_unnamed_211, fragment_unnamed_212, fragment_unnamed_213))) + 0.60000002384185791015625f, 0.0f);
				float fragment_unnamed_426 = max(((-0.0f) - dot(float3(fragment_unnamed_401, fragment_unnamed_403, fragment_unnamed_404), float3(fragment_unnamed_401, fragment_unnamed_403, fragment_unnamed_404))) + 0.60000002384185791015625f, 0.0f);
				float fragment_unnamed_427 = fragment_unnamed_423 * fragment_unnamed_423;
				float fragment_unnamed_428 = fragment_unnamed_424 * fragment_unnamed_424;
				float fragment_unnamed_429 = fragment_unnamed_425 * fragment_unnamed_425;
				float fragment_unnamed_430 = fragment_unnamed_426 * fragment_unnamed_426;
				float fragment_unnamed_438 = mad(dot(float4(fragment_unnamed_427 * fragment_unnamed_427, fragment_unnamed_428 * fragment_unnamed_428, fragment_unnamed_429 * fragment_unnamed_429, fragment_unnamed_430 * fragment_unnamed_430), float4(dot(float3(fragment_unnamed_97, fragment_unnamed_98, fragment_unnamed_99), float3(fragment_unnamed_368 * fragment_unnamed_336, fragment_unnamed_368 * fragment_unnamed_337, fragment_unnamed_368 * fragment_unnamed_317)), dot(float3(fragment_unnamed_202, fragment_unnamed_203, fragment_unnamed_204), float3(fragment_unnamed_371 * fragment_unnamed_334, fragment_unnamed_371 * fragment_unnamed_335, fragment_unnamed_371 * fragment_unnamed_318)), dot(float3(fragment_unnamed_211, fragment_unnamed_212, fragment_unnamed_213), float3(fragment_unnamed_354 * fragment_unnamed_372, fragment_unnamed_355 * fragment_unnamed_372, fragment_unnamed_320 * fragment_unnamed_372)), dot(float3(fragment_unnamed_401, fragment_unnamed_403, fragment_unnamed_404), float3(fragment_unnamed_373 * fragment_unnamed_356, fragment_unnamed_373 * fragment_unnamed_357, fragment_unnamed_373 * fragment_unnamed_319)))), 21.0f, 0.5f);
				float4 fragment_unnamed_460 = _MainTex.Sample(sampler_linear_clamp_S0, float3(mad(fragment_unnamed_438, fragment_uniform_buffer_0[0u].x, fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, mad(fragment_unnamed_438, fragment_uniform_buffer_0[0u].x, fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				fragment_output_0.x = fragment_unnamed_460.x;
				fragment_output_0.y = fragment_unnamed_460.y;
				fragment_output_0.z = fragment_unnamed_460.z;
				fragment_output_0.w = fragment_unnamed_460.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Strength, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], _Distance, fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], fragment_uniform_buffer_0[0][1], _Speed, fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_1[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

				fragment_uniform_buffer_1[76] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_input_1 = stage_input.fragment_input_1;
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
}
