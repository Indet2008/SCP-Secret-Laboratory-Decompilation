Shader "Hidden/Shader/BloodHit"
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
			Name "BloodHit"
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
			GpuProgramID 13780

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


			float _LightReflect;
			float4 _Hits;
			float4 _BloodHits;
			float4 _FullHits;
			float4 _RTHandleScale;

			static float4 fragment_uniform_buffer_0[4];
			static float4 fragment_uniform_buffer_1[53];
			Texture2DArray<float4> _MainTex;
			Texture2D<float4> _BloodTex;
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
				float4 fragment_unnamed_53 = _BloodTex.Sample(sampler_linear_clamp_S0, float2(mad(fragment_input_1.x, 0.5f, 0.5f), mad(fragment_input_1.y, 0.5f, 0.5f)));
				float4 fragment_unnamed_58 = _BloodTex.Sample(sampler_linear_clamp_S0, float2(mad(fragment_input_1.x, 0.5f, 0.0f), mad(fragment_input_1.y, 0.5f, 0.5f)));
				float4 fragment_unnamed_78 = _BloodTex.Sample(sampler_linear_clamp_S0, float2(fragment_input_1.x * 0.5f, fragment_input_1.y * 0.5f));
				float4 fragment_unnamed_93 = _BloodTex.Sample(sampler_linear_clamp_S0, float2(mad(fragment_input_1.x, 0.5f, 0.5f), mad(fragment_input_1.y, 0.5f, 0.0f)));
				float fragment_unnamed_139 = mad(fragment_unnamed_93.z, fragment_uniform_buffer_0[3u].w, mad(fragment_unnamed_78.z, fragment_uniform_buffer_0[3u].z, mad(fragment_unnamed_53.z, fragment_uniform_buffer_0[3u].y, mad(fragment_unnamed_58.z, fragment_uniform_buffer_0[3u].x, mad(fragment_unnamed_93.y, fragment_uniform_buffer_0[2u].w, mad(fragment_unnamed_78.y, fragment_uniform_buffer_0[2u].z, mad(fragment_unnamed_53.y, fragment_uniform_buffer_0[2u].y, mad(fragment_unnamed_58.y, fragment_uniform_buffer_0[2u].x, mad(fragment_unnamed_93.x, fragment_uniform_buffer_0[1u].w, mad(fragment_unnamed_78.x, fragment_uniform_buffer_0[1u].z, mad(fragment_unnamed_58.x, fragment_uniform_buffer_0[1u].x, fragment_unnamed_53.x * fragment_uniform_buffer_0[1u].y))))))))))) * fragment_uniform_buffer_0[0u].x;
				float4 fragment_unnamed_157 = _MainTex.Sample(sampler_linear_clamp_S0, float3(mad(fragment_unnamed_139, 0.0625f, fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, mad(fragment_unnamed_139, 0.0625f, fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				fragment_output_0.x = fragment_unnamed_157.x + mad(fragment_unnamed_139, 0.00390625f, fragment_unnamed_139);
				fragment_output_0.y = mad(fragment_unnamed_139, 0.00390625f, fragment_unnamed_157.y);
				fragment_output_0.z = mad(fragment_unnamed_139, 0.00390625f, fragment_unnamed_157.z);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_LightReflect, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[1] = float4(_Hits[0], _Hits[1], _Hits[2], _Hits[3]);

				fragment_uniform_buffer_0[2] = float4(_BloodHits[0], _BloodHits[1], _BloodHits[2], _BloodHits[3]);

				fragment_uniform_buffer_0[3] = float4(_FullHits[0], _FullHits[1], _FullHits[2], _FullHits[3]);

				fragment_uniform_buffer_1[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

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


			float _LightReflect;
			float4 _Hits;
			float4 _BloodHits;
			float4 _FullHits;
			float4 _RTHandleScale;

			static float4 fragment_uniform_buffer_0[4];
			static float4 fragment_uniform_buffer_1[53];
			Texture2DArray<float4> _MainTex;
			Texture2D<float4> _BloodTex;
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
				float4 fragment_unnamed_53 = _BloodTex.Sample(sampler_linear_clamp_S0, float2(mad(fragment_input_1.x, 0.5f, 0.5f), mad(fragment_input_1.y, 0.5f, 0.5f)));
				float4 fragment_unnamed_58 = _BloodTex.Sample(sampler_linear_clamp_S0, float2(mad(fragment_input_1.x, 0.5f, 0.0f), mad(fragment_input_1.y, 0.5f, 0.5f)));
				float4 fragment_unnamed_78 = _BloodTex.Sample(sampler_linear_clamp_S0, float2(fragment_input_1.x * 0.5f, fragment_input_1.y * 0.5f));
				float4 fragment_unnamed_93 = _BloodTex.Sample(sampler_linear_clamp_S0, float2(mad(fragment_input_1.x, 0.5f, 0.5f), mad(fragment_input_1.y, 0.5f, 0.0f)));
				float fragment_unnamed_139 = mad(fragment_unnamed_93.z, fragment_uniform_buffer_0[3u].w, mad(fragment_unnamed_78.z, fragment_uniform_buffer_0[3u].z, mad(fragment_unnamed_53.z, fragment_uniform_buffer_0[3u].y, mad(fragment_unnamed_58.z, fragment_uniform_buffer_0[3u].x, mad(fragment_unnamed_93.y, fragment_uniform_buffer_0[2u].w, mad(fragment_unnamed_78.y, fragment_uniform_buffer_0[2u].z, mad(fragment_unnamed_53.y, fragment_uniform_buffer_0[2u].y, mad(fragment_unnamed_58.y, fragment_uniform_buffer_0[2u].x, mad(fragment_unnamed_93.x, fragment_uniform_buffer_0[1u].w, mad(fragment_unnamed_78.x, fragment_uniform_buffer_0[1u].z, mad(fragment_unnamed_58.x, fragment_uniform_buffer_0[1u].x, fragment_unnamed_53.x * fragment_uniform_buffer_0[1u].y))))))))))) * fragment_uniform_buffer_0[0u].x;
				float4 fragment_unnamed_157 = _MainTex.Sample(sampler_linear_clamp_S0, float3(mad(fragment_unnamed_139, 0.0625f, fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, mad(fragment_unnamed_139, 0.0625f, fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				fragment_output_0.x = fragment_unnamed_157.x + mad(fragment_unnamed_139, 0.00390625f, fragment_unnamed_139);
				fragment_output_0.y = mad(fragment_unnamed_139, 0.00390625f, fragment_unnamed_157.y);
				fragment_output_0.z = mad(fragment_unnamed_139, 0.00390625f, fragment_unnamed_157.z);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_LightReflect, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[1] = float4(_Hits[0], _Hits[1], _Hits[2], _Hits[3]);

				fragment_uniform_buffer_0[2] = float4(_BloodHits[0], _BloodHits[1], _BloodHits[2], _BloodHits[3]);

				fragment_uniform_buffer_0[3] = float4(_FullHits[0], _FullHits[1], _FullHits[2], _FullHits[3]);

				fragment_uniform_buffer_1[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

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
