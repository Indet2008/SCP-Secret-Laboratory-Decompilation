Shader "Hidden/Shader/Artefact"
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
			Name "Artefact"
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
			GpuProgramID 28737

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


			float4 _Effects;
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
				float fragment_unnamed_59 = floor(fragment_uniform_buffer_1[76u].y * 12.0f);
				float fragment_unnamed_77 = frac(sin(dot(float2(floor(fragment_input_1.x * 24.0f) * fragment_unnamed_59, floor(fragment_input_1.y * 9.0f) * fragment_unnamed_59), float2(127.09999847412109375f, 311.70001220703125f))) * 43758.546875f);
				float fragment_unnamed_78 = frac(sin(dot(float2(floor(fragment_input_1.x * 8.0f) * fragment_unnamed_59, floor(fragment_input_1.y * 4.0f) * fragment_unnamed_59), float2(127.09999847412109375f, 311.70001220703125f))) * 43758.546875f);
				float fragment_unnamed_79 = fragment_unnamed_77 * fragment_unnamed_77;
				float fragment_unnamed_81 = fragment_unnamed_79 * fragment_unnamed_79;
				float fragment_unnamed_110 = exp2(log2(frac(sin(dot(float2(fragment_unnamed_59 * 7.234099864959716796875f, fragment_unnamed_59 * 1.0f), float2(127.09999847412109375f, 311.70001220703125f))) * 43758.546875f)) * 17.0f);
				float fragment_unnamed_129 = frac(sin(dot(float2(fragment_unnamed_59 * fragment_input_1.x, fragment_unnamed_59 * fragment_input_1.y), float2(127.09999847412109375f, 311.70001220703125f))) * 43758.546875f);
				float fragment_unnamed_134 = mad((fragment_unnamed_81 * fragment_unnamed_81) * fragment_uniform_buffer_0[0u].z, (fragment_unnamed_78 * fragment_unnamed_78) * fragment_unnamed_78, (-0.0f) - (fragment_unnamed_110 + fragment_unnamed_110)) * 0.0500000007450580596923828125f;
				float4 fragment_unnamed_206 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_input_1.x * fragment_uniform_buffer_1[52u].x, fragment_input_1.y * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float fragment_unnamed_208 = fragment_unnamed_206.x;
				float fragment_unnamed_209 = fragment_unnamed_206.y;
				float fragment_unnamed_210 = fragment_unnamed_206.z;
				float fragment_unnamed_211 = fragment_unnamed_206.w;
				fragment_output_0.x = mad(fragment_uniform_buffer_0[0u].x, ((-0.0f) - fragment_unnamed_208) + mad(mad(fragment_unnamed_129, fragment_uniform_buffer_0[0u].w, -2.0f), 0.07999999821186065673828125f, fragment_unnamed_208), fragment_unnamed_208);
				fragment_output_0.y = mad(fragment_uniform_buffer_0[0u].x, ((-0.0f) - fragment_unnamed_209) + mad(mad(mad((-0.0f) - fragment_unnamed_129, fragment_uniform_buffer_0[0u].y, 1.0f), fragment_uniform_buffer_0[0u].w, -2.0f), 0.07999999821186065673828125f, _MainTex.Sample(sampler_linear_clamp_S0, float3(((frac(sin(dot(float2(fragment_unnamed_59 * 5.0f, fragment_unnamed_59 * 1.0f), float2(127.09999847412109375f, 311.70001220703125f))) * 43758.546875f) * fragment_unnamed_134) + fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, (asfloat(0u) + fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u))).y), fragment_unnamed_209);
				fragment_output_0.z = mad(fragment_uniform_buffer_0[0u].x, ((-0.0f) - fragment_unnamed_210) + mad(mad(mad(fragment_unnamed_129, 0.5f, 0.5f), fragment_uniform_buffer_0[0u].w, -2.0f), 0.07999999821186065673828125f, _MainTex.Sample(sampler_linear_clamp_S0, float3((((-0.0f) - (frac(sin(dot(float2(fragment_unnamed_59 * 31.0f, fragment_unnamed_59 * 1.0f), float2(127.09999847412109375f, 311.70001220703125f))) * 43758.546875f) * fragment_unnamed_134)) + fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, (((-0.0f) - asfloat(0u)) + fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u))).z), fragment_unnamed_210);
				fragment_output_0.w = mad(fragment_uniform_buffer_0[0u].x, ((-0.0f) - fragment_unnamed_211) + asfloat(1045220557u), fragment_unnamed_211);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Effects[0], _Effects[1], _Effects[2], _Effects[3]);

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


			float4 _Effects;
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
				float fragment_unnamed_59 = floor(fragment_uniform_buffer_1[76u].y * 12.0f);
				float fragment_unnamed_77 = frac(sin(dot(float2(floor(fragment_input_1.x * 24.0f) * fragment_unnamed_59, floor(fragment_input_1.y * 9.0f) * fragment_unnamed_59), float2(127.09999847412109375f, 311.70001220703125f))) * 43758.546875f);
				float fragment_unnamed_78 = frac(sin(dot(float2(floor(fragment_input_1.x * 8.0f) * fragment_unnamed_59, floor(fragment_input_1.y * 4.0f) * fragment_unnamed_59), float2(127.09999847412109375f, 311.70001220703125f))) * 43758.546875f);
				float fragment_unnamed_79 = fragment_unnamed_77 * fragment_unnamed_77;
				float fragment_unnamed_81 = fragment_unnamed_79 * fragment_unnamed_79;
				float fragment_unnamed_110 = exp2(log2(frac(sin(dot(float2(fragment_unnamed_59 * 7.234099864959716796875f, fragment_unnamed_59 * 1.0f), float2(127.09999847412109375f, 311.70001220703125f))) * 43758.546875f)) * 17.0f);
				float fragment_unnamed_129 = frac(sin(dot(float2(fragment_unnamed_59 * fragment_input_1.x, fragment_unnamed_59 * fragment_input_1.y), float2(127.09999847412109375f, 311.70001220703125f))) * 43758.546875f);
				float fragment_unnamed_134 = mad((fragment_unnamed_81 * fragment_unnamed_81) * fragment_uniform_buffer_0[0u].z, (fragment_unnamed_78 * fragment_unnamed_78) * fragment_unnamed_78, (-0.0f) - (fragment_unnamed_110 + fragment_unnamed_110)) * 0.0500000007450580596923828125f;
				float4 fragment_unnamed_206 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_input_1.x * fragment_uniform_buffer_1[52u].x, fragment_input_1.y * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float fragment_unnamed_208 = fragment_unnamed_206.x;
				float fragment_unnamed_209 = fragment_unnamed_206.y;
				float fragment_unnamed_210 = fragment_unnamed_206.z;
				float fragment_unnamed_211 = fragment_unnamed_206.w;
				fragment_output_0.x = mad(fragment_uniform_buffer_0[0u].x, ((-0.0f) - fragment_unnamed_208) + mad(mad(fragment_unnamed_129, fragment_uniform_buffer_0[0u].w, -2.0f), 0.07999999821186065673828125f, fragment_unnamed_208), fragment_unnamed_208);
				fragment_output_0.y = mad(fragment_uniform_buffer_0[0u].x, ((-0.0f) - fragment_unnamed_209) + mad(mad(mad((-0.0f) - fragment_unnamed_129, fragment_uniform_buffer_0[0u].y, 1.0f), fragment_uniform_buffer_0[0u].w, -2.0f), 0.07999999821186065673828125f, _MainTex.Sample(sampler_linear_clamp_S0, float3(((frac(sin(dot(float2(fragment_unnamed_59 * 5.0f, fragment_unnamed_59 * 1.0f), float2(127.09999847412109375f, 311.70001220703125f))) * 43758.546875f) * fragment_unnamed_134) + fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, (asfloat(0u) + fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u))).y), fragment_unnamed_209);
				fragment_output_0.z = mad(fragment_uniform_buffer_0[0u].x, ((-0.0f) - fragment_unnamed_210) + mad(mad(mad(fragment_unnamed_129, 0.5f, 0.5f), fragment_uniform_buffer_0[0u].w, -2.0f), 0.07999999821186065673828125f, _MainTex.Sample(sampler_linear_clamp_S0, float3((((-0.0f) - (frac(sin(dot(float2(fragment_unnamed_59 * 31.0f, fragment_unnamed_59 * 1.0f), float2(127.09999847412109375f, 311.70001220703125f))) * 43758.546875f) * fragment_unnamed_134)) + fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, (((-0.0f) - asfloat(0u)) + fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u))).z), fragment_unnamed_210);
				fragment_output_0.w = mad(fragment_uniform_buffer_0[0u].x, ((-0.0f) - fragment_unnamed_211) + asfloat(1045220557u), fragment_unnamed_211);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Effects[0], _Effects[1], _Effects[2], _Effects[3]);

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
