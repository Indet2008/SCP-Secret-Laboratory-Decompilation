Shader "Hidden/Shader/DoubleVision"
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
			GpuProgramID 46902

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


			float _Amount;
			float4 _RTHandleScale;

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[53];
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
				float4 fragment_unnamed_51 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_input_1.x * fragment_uniform_buffer_1[52u].x, fragment_input_1.y * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float fragment_unnamed_64 = asfloat(asuint(fragment_uniform_buffer_0[0u]).x);
				float fragment_unnamed_65 = asfloat(0u);
				float4 fragment_unnamed_93 = _MainTex.Sample(sampler_linear_clamp_S0, float3((((-0.0f) - fragment_unnamed_64) + fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, (((-0.0f) - fragment_unnamed_65) + fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float4 fragment_unnamed_104 = _MainTex.Sample(sampler_linear_clamp_S0, float3((fragment_unnamed_64 + fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, (fragment_unnamed_65 + fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				fragment_output_0.x = ((fragment_unnamed_51.x + fragment_unnamed_93.x) + fragment_unnamed_104.x) * 0.3333333432674407958984375f;
				fragment_output_0.y = ((fragment_unnamed_51.y + fragment_unnamed_93.y) + fragment_unnamed_104.y) * 0.3333333432674407958984375f;
				fragment_output_0.z = ((fragment_unnamed_51.z + fragment_unnamed_93.z) + fragment_unnamed_104.z) * 0.3333333432674407958984375f;
				fragment_output_0.w = ((fragment_unnamed_51.w + fragment_unnamed_93.w) + fragment_unnamed_104.w) * 0.3333333432674407958984375f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Amount, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

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


			float _Amount;
			float4 _RTHandleScale;

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[53];
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
				float4 fragment_unnamed_51 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_input_1.x * fragment_uniform_buffer_1[52u].x, fragment_input_1.y * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float fragment_unnamed_64 = asfloat(asuint(fragment_uniform_buffer_0[0u]).x);
				float fragment_unnamed_65 = asfloat(0u);
				float4 fragment_unnamed_93 = _MainTex.Sample(sampler_linear_clamp_S0, float3((((-0.0f) - fragment_unnamed_64) + fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, (((-0.0f) - fragment_unnamed_65) + fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float4 fragment_unnamed_104 = _MainTex.Sample(sampler_linear_clamp_S0, float3((fragment_unnamed_64 + fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, (fragment_unnamed_65 + fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				fragment_output_0.x = ((fragment_unnamed_51.x + fragment_unnamed_93.x) + fragment_unnamed_104.x) * 0.3333333432674407958984375f;
				fragment_output_0.y = ((fragment_unnamed_51.y + fragment_unnamed_93.y) + fragment_unnamed_104.y) * 0.3333333432674407958984375f;
				fragment_output_0.z = ((fragment_unnamed_51.z + fragment_unnamed_93.z) + fragment_unnamed_104.z) * 0.3333333432674407958984375f;
				fragment_output_0.w = ((fragment_unnamed_51.w + fragment_unnamed_93.w) + fragment_unnamed_104.w) * 0.3333333432674407958984375f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Amount, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

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
		Pass
		{
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
			GpuProgramID 107157

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


			float _Amount;
			float4 _RTHandleScale;

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[53];
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
				float fragment_unnamed_44 = mad(fragment_input_1.x, 2.0f, -1.0f);
				float fragment_unnamed_45 = mad(fragment_input_1.y, 2.0f, -1.0f);
				float fragment_unnamed_46 = dot(float2(fragment_unnamed_44, fragment_unnamed_45), float2(fragment_unnamed_44, fragment_unnamed_45));
				float4 fragment_unnamed_84 = _MainTex.Sample(sampler_linear_clamp_S0, float3(mad((mad(fragment_input_1.x, 2.0f, -1.0f) * fragment_unnamed_46) * fragment_uniform_buffer_0[0u].x, -0.3333333432674407958984375f, fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, mad((mad(fragment_input_1.y, 2.0f, -1.0f) * fragment_unnamed_46) * fragment_uniform_buffer_0[0u].x, -0.3333333432674407958984375f, fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float4 fragment_unnamed_102 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_input_1.x * fragment_uniform_buffer_1[52u].x, fragment_input_1.y * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float4 fragment_unnamed_113 = _MainTex.Sample(sampler_linear_clamp_S0, float3(mad((fragment_unnamed_44 * fragment_unnamed_46) * fragment_uniform_buffer_0[0u].x, -0.666666686534881591796875f, fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, mad((fragment_unnamed_45 * fragment_unnamed_46) * fragment_uniform_buffer_0[0u].x, -0.666666686534881591796875f, fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				fragment_output_0.x = (fragment_unnamed_113.x + (fragment_unnamed_84.x + fragment_unnamed_102.x)) * 0.3333333432674407958984375f;
				fragment_output_0.y = (fragment_unnamed_113.y + (fragment_unnamed_84.y + fragment_unnamed_102.y)) * 0.3333333432674407958984375f;
				fragment_output_0.z = (fragment_unnamed_113.z + (fragment_unnamed_84.z + fragment_unnamed_102.z)) * 0.3333333432674407958984375f;
				fragment_output_0.w = (fragment_unnamed_113.w + (fragment_unnamed_84.w + fragment_unnamed_102.w)) * 0.3333333432674407958984375f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Amount, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

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


			float _Amount;
			float4 _RTHandleScale;

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[53];
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
				float fragment_unnamed_44 = mad(fragment_input_1.x, 2.0f, -1.0f);
				float fragment_unnamed_45 = mad(fragment_input_1.y, 2.0f, -1.0f);
				float fragment_unnamed_46 = dot(float2(fragment_unnamed_44, fragment_unnamed_45), float2(fragment_unnamed_44, fragment_unnamed_45));
				float4 fragment_unnamed_84 = _MainTex.Sample(sampler_linear_clamp_S0, float3(mad((mad(fragment_input_1.x, 2.0f, -1.0f) * fragment_unnamed_46) * fragment_uniform_buffer_0[0u].x, -0.3333333432674407958984375f, fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, mad((mad(fragment_input_1.y, 2.0f, -1.0f) * fragment_unnamed_46) * fragment_uniform_buffer_0[0u].x, -0.3333333432674407958984375f, fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float4 fragment_unnamed_102 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_input_1.x * fragment_uniform_buffer_1[52u].x, fragment_input_1.y * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float4 fragment_unnamed_113 = _MainTex.Sample(sampler_linear_clamp_S0, float3(mad((fragment_unnamed_44 * fragment_unnamed_46) * fragment_uniform_buffer_0[0u].x, -0.666666686534881591796875f, fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, mad((fragment_unnamed_45 * fragment_unnamed_46) * fragment_uniform_buffer_0[0u].x, -0.666666686534881591796875f, fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				fragment_output_0.x = (fragment_unnamed_113.x + (fragment_unnamed_84.x + fragment_unnamed_102.x)) * 0.3333333432674407958984375f;
				fragment_output_0.y = (fragment_unnamed_113.y + (fragment_unnamed_84.y + fragment_unnamed_102.y)) * 0.3333333432674407958984375f;
				fragment_output_0.z = (fragment_unnamed_113.z + (fragment_unnamed_84.z + fragment_unnamed_102.z)) * 0.3333333432674407958984375f;
				fragment_output_0.w = (fragment_unnamed_113.w + (fragment_unnamed_84.w + fragment_unnamed_102.w)) * 0.3333333432674407958984375f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Amount, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

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
