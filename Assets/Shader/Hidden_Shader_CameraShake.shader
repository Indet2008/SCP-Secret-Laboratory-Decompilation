Shader "Hidden/Shader/CameraShake"
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
			Name "CameraShake"
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
			GpuProgramID 11201

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


			float4 _JitterJump;
			float4 _ColorShake;
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
				uint4 fragment_unnamed_43 = asuint(fragment_uniform_buffer_1[76u]);
				uint fragment_unnamed_44 = fragment_unnamed_43.x;
				float fragment_unnamed_57 = mad(frac(sin(dot(float2(fragment_input_1.y, asfloat(fragment_unnamed_44)), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), 2.0f, -1.0f);
				float fragment_unnamed_91 = mad(frac(sin(dot(float2(asfloat(fragment_unnamed_44), asfloat(1073741824u)), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f) + (-0.5f), fragment_uniform_buffer_0[1u].z, mad(fragment_unnamed_57, asfloat(((abs(fragment_unnamed_57) >= fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & 1065353216u) * fragment_uniform_buffer_0[0u].x, fragment_input_1.x));
				float fragment_unnamed_109 = mad(fragment_uniform_buffer_0[0u].z, frac(fragment_input_1.y + fragment_uniform_buffer_0[0u].w) + ((-0.0f) - fragment_input_1.y), fragment_input_1.y);
				fragment_output_0.y = _MainTex.Sample(sampler_linear_clamp_S0, float3(frac(mad(sin(fragment_unnamed_109 + fragment_uniform_buffer_0[1u].y), fragment_uniform_buffer_0[1u].x, fragment_unnamed_91)) * fragment_uniform_buffer_1[52u].x, frac(fragment_unnamed_109) * fragment_uniform_buffer_1[52u].y, asfloat(0u))).y;
				float4 fragment_unnamed_147 = _MainTex.Sample(sampler_linear_clamp_S0, float3(frac(fragment_unnamed_91) * fragment_uniform_buffer_1[52u].x, frac(fragment_unnamed_109) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				fragment_output_0.x = fragment_unnamed_147.x;
				fragment_output_0.z = fragment_unnamed_147.z;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_JitterJump[0], _JitterJump[1], _JitterJump[2], _JitterJump[3]);

				fragment_uniform_buffer_0[1] = float4(_ColorShake[0], _ColorShake[1], _ColorShake[2], _ColorShake[3]);

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


			float4 _JitterJump;
			float4 _ColorShake;
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
				uint4 fragment_unnamed_43 = asuint(fragment_uniform_buffer_1[76u]);
				uint fragment_unnamed_44 = fragment_unnamed_43.x;
				float fragment_unnamed_57 = mad(frac(sin(dot(float2(fragment_input_1.y, asfloat(fragment_unnamed_44)), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), 2.0f, -1.0f);
				float fragment_unnamed_91 = mad(frac(sin(dot(float2(asfloat(fragment_unnamed_44), asfloat(1073741824u)), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f) + (-0.5f), fragment_uniform_buffer_0[1u].z, mad(fragment_unnamed_57, asfloat(((abs(fragment_unnamed_57) >= fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & 1065353216u) * fragment_uniform_buffer_0[0u].x, fragment_input_1.x));
				float fragment_unnamed_109 = mad(fragment_uniform_buffer_0[0u].z, frac(fragment_input_1.y + fragment_uniform_buffer_0[0u].w) + ((-0.0f) - fragment_input_1.y), fragment_input_1.y);
				fragment_output_0.y = _MainTex.Sample(sampler_linear_clamp_S0, float3(frac(mad(sin(fragment_unnamed_109 + fragment_uniform_buffer_0[1u].y), fragment_uniform_buffer_0[1u].x, fragment_unnamed_91)) * fragment_uniform_buffer_1[52u].x, frac(fragment_unnamed_109) * fragment_uniform_buffer_1[52u].y, asfloat(0u))).y;
				float4 fragment_unnamed_147 = _MainTex.Sample(sampler_linear_clamp_S0, float3(frac(fragment_unnamed_91) * fragment_uniform_buffer_1[52u].x, frac(fragment_unnamed_109) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				fragment_output_0.x = fragment_unnamed_147.x;
				fragment_output_0.z = fragment_unnamed_147.z;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_JitterJump[0], _JitterJump[1], _JitterJump[2], _JitterJump[3]);

				fragment_uniform_buffer_0[1] = float4(_ColorShake[0], _ColorShake[1], _ColorShake[2], _ColorShake[3]);

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
