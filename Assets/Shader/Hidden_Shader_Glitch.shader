Shader "Hidden/Shader/Glitch"
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
			Name "Glitch"
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
			GpuProgramID 51651

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


			float _Glitch;
			float _Noise;
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
				float fragment_unnamed_46 = fragment_uniform_buffer_1[76u].y * 100.0f;
				float fragment_unnamed_68 = frac(sin(dot(float2(fragment_unnamed_46 * fragment_input_1.x, fragment_unnamed_46 * fragment_input_1.y), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f) * 0.5f;
				float fragment_unnamed_78 = frac(sin(dot(mad(floor(fragment_input_1.y * 16.0f), 0.0625f, floor(fragment_uniform_buffer_1[76u].y * 4.0f) * 37.5f).xx, float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f) * 16.0f;
				float fragment_unnamed_87 = mad(floor(fragment_unnamed_78 * fragment_uniform_buffer_1[76u].y) / fragment_unnamed_78, 5.0f, fragment_input_1.y);
				float fragment_unnamed_114 = mad(mad(frac(sin(dot((floor(fragment_unnamed_87 * 11.0f) * 0.0909090936183929443359375f).xx, float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), 0.5f, frac(sin(dot((floor(fragment_unnamed_87 * 7.0f) * 0.14285714924335479736328125f).xx, float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f) * 1.5f), 2.0f, -1.0f);
				float fragment_unnamed_134 = clamp((abs(fragment_unnamed_114) + (-0.60000002384185791015625f)) * 2.5f, 0.0f, 1.0f) * float(int((-((0.0f < fragment_unnamed_114) ? 4294967295u : 0u)) + ((fragment_unnamed_114 < 0.0f) ? 4294967295u : 0u)));
				float fragment_unnamed_146 = fragment_unnamed_134 * fragment_uniform_buffer_0[0u].x;
				float4 fragment_unnamed_181 = _MainTex.Sample(sampler_linear_clamp_S0, float3(clamp((fragment_unnamed_146 * 0.100000001490116119384765625f) + fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_1[52u].x, clamp(asfloat(0u) + fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float fragment_unnamed_184 = fragment_unnamed_181.x;
				float fragment_unnamed_185 = fragment_unnamed_181.y;
				float fragment_unnamed_186 = fragment_unnamed_181.z;
				float fragment_unnamed_187 = fragment_unnamed_181.w;
				float fragment_unnamed_194 = dot(float3(fragment_unnamed_184, fragment_unnamed_185, fragment_unnamed_186), float3(-0.14712999761104583740234375f, -0.2888599932193756103515625f, 0.43599998950958251953125f)) / mad((-0.0f) - (abs(fragment_unnamed_146) * 3.0f), clamp(mad((-0.0f) - fragment_uniform_buffer_0[0u].x, fragment_unnamed_134, 10.5f), 0.0f, 1.0f), 1.0f);
				float fragment_unnamed_201 = mad(fragment_unnamed_146 * 1.125f, clamp(mad(fragment_uniform_buffer_0[0u].x, fragment_unnamed_134, -0.5f), 0.0f, 1.0f), dot(float3(fragment_unnamed_184, fragment_unnamed_185, fragment_unnamed_186), float3(0.6150000095367431640625f, -0.51498997211456298828125f, -0.100010000169277191162109375f)));
				float fragment_unnamed_207 = dot(float3(fragment_unnamed_184, fragment_unnamed_185, fragment_unnamed_186), float3(-0.2989999949932098388671875f, 0.58700001239776611328125f, 0.114000000059604644775390625f));
				float fragment_unnamed_213 = dot(float2(-0.3946500122547149658203125f, -0.5806000232696533203125f), float2(fragment_unnamed_194, fragment_unnamed_201)) + fragment_unnamed_207;
				float fragment_unnamed_214 = mad(fragment_unnamed_201, 1.13982999324798583984375f, fragment_unnamed_207);
				float fragment_unnamed_216 = mad(fragment_unnamed_194, 2.0321099758148193359375f, fragment_unnamed_207);
				fragment_output_0.x = mad(fragment_uniform_buffer_0[0u].y, mad(mad(fragment_unnamed_68, ((-0.0f) - fragment_unnamed_214) + 0.0f, fragment_unnamed_214), 2.0f, (-0.0f) - fragment_unnamed_184), fragment_unnamed_184);
				fragment_output_0.y = mad(fragment_uniform_buffer_0[0u].y, mad(mad(fragment_unnamed_68, ((-0.0f) - fragment_unnamed_213) + 0.0f, fragment_unnamed_213), 2.0f, (-0.0f) - fragment_unnamed_185), fragment_unnamed_185);
				fragment_output_0.z = mad(fragment_uniform_buffer_0[0u].y, mad(mad(fragment_unnamed_68, ((-0.0f) - fragment_unnamed_216) + 0.0f, fragment_unnamed_216), 2.0f, (-0.0f) - fragment_unnamed_186), fragment_unnamed_186);
				fragment_output_0.w = mad(fragment_uniform_buffer_0[0u].y, mad(mad(fragment_unnamed_68, ((-0.0f) - fragment_unnamed_187) + 1.0f, fragment_unnamed_187), 2.0f, (-0.0f) - fragment_unnamed_187), fragment_unnamed_187);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Glitch, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], _Noise, fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

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


			float _Glitch;
			float _Noise;
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
				float fragment_unnamed_46 = fragment_uniform_buffer_1[76u].y * 100.0f;
				float fragment_unnamed_68 = frac(sin(dot(float2(fragment_unnamed_46 * fragment_input_1.x, fragment_unnamed_46 * fragment_input_1.y), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f) * 0.5f;
				float fragment_unnamed_78 = frac(sin(dot(mad(floor(fragment_input_1.y * 16.0f), 0.0625f, floor(fragment_uniform_buffer_1[76u].y * 4.0f) * 37.5f).xx, float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f) * 16.0f;
				float fragment_unnamed_87 = mad(floor(fragment_unnamed_78 * fragment_uniform_buffer_1[76u].y) / fragment_unnamed_78, 5.0f, fragment_input_1.y);
				float fragment_unnamed_114 = mad(mad(frac(sin(dot((floor(fragment_unnamed_87 * 11.0f) * 0.0909090936183929443359375f).xx, float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), 0.5f, frac(sin(dot((floor(fragment_unnamed_87 * 7.0f) * 0.14285714924335479736328125f).xx, float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f) * 1.5f), 2.0f, -1.0f);
				float fragment_unnamed_134 = clamp((abs(fragment_unnamed_114) + (-0.60000002384185791015625f)) * 2.5f, 0.0f, 1.0f) * float(int((-((0.0f < fragment_unnamed_114) ? 4294967295u : 0u)) + ((fragment_unnamed_114 < 0.0f) ? 4294967295u : 0u)));
				float fragment_unnamed_146 = fragment_unnamed_134 * fragment_uniform_buffer_0[0u].x;
				float4 fragment_unnamed_181 = _MainTex.Sample(sampler_linear_clamp_S0, float3(clamp((fragment_unnamed_146 * 0.100000001490116119384765625f) + fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_1[52u].x, clamp(asfloat(0u) + fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float fragment_unnamed_184 = fragment_unnamed_181.x;
				float fragment_unnamed_185 = fragment_unnamed_181.y;
				float fragment_unnamed_186 = fragment_unnamed_181.z;
				float fragment_unnamed_187 = fragment_unnamed_181.w;
				float fragment_unnamed_194 = dot(float3(fragment_unnamed_184, fragment_unnamed_185, fragment_unnamed_186), float3(-0.14712999761104583740234375f, -0.2888599932193756103515625f, 0.43599998950958251953125f)) / mad((-0.0f) - (abs(fragment_unnamed_146) * 3.0f), clamp(mad((-0.0f) - fragment_uniform_buffer_0[0u].x, fragment_unnamed_134, 10.5f), 0.0f, 1.0f), 1.0f);
				float fragment_unnamed_201 = mad(fragment_unnamed_146 * 1.125f, clamp(mad(fragment_uniform_buffer_0[0u].x, fragment_unnamed_134, -0.5f), 0.0f, 1.0f), dot(float3(fragment_unnamed_184, fragment_unnamed_185, fragment_unnamed_186), float3(0.6150000095367431640625f, -0.51498997211456298828125f, -0.100010000169277191162109375f)));
				float fragment_unnamed_207 = dot(float3(fragment_unnamed_184, fragment_unnamed_185, fragment_unnamed_186), float3(-0.2989999949932098388671875f, 0.58700001239776611328125f, 0.114000000059604644775390625f));
				float fragment_unnamed_213 = dot(float2(-0.3946500122547149658203125f, -0.5806000232696533203125f), float2(fragment_unnamed_194, fragment_unnamed_201)) + fragment_unnamed_207;
				float fragment_unnamed_214 = mad(fragment_unnamed_201, 1.13982999324798583984375f, fragment_unnamed_207);
				float fragment_unnamed_216 = mad(fragment_unnamed_194, 2.0321099758148193359375f, fragment_unnamed_207);
				fragment_output_0.x = mad(fragment_uniform_buffer_0[0u].y, mad(mad(fragment_unnamed_68, ((-0.0f) - fragment_unnamed_214) + 0.0f, fragment_unnamed_214), 2.0f, (-0.0f) - fragment_unnamed_184), fragment_unnamed_184);
				fragment_output_0.y = mad(fragment_uniform_buffer_0[0u].y, mad(mad(fragment_unnamed_68, ((-0.0f) - fragment_unnamed_213) + 0.0f, fragment_unnamed_213), 2.0f, (-0.0f) - fragment_unnamed_185), fragment_unnamed_185);
				fragment_output_0.z = mad(fragment_uniform_buffer_0[0u].y, mad(mad(fragment_unnamed_68, ((-0.0f) - fragment_unnamed_216) + 0.0f, fragment_unnamed_216), 2.0f, (-0.0f) - fragment_unnamed_186), fragment_unnamed_186);
				fragment_output_0.w = mad(fragment_uniform_buffer_0[0u].y, mad(mad(fragment_unnamed_68, ((-0.0f) - fragment_unnamed_187) + 1.0f, fragment_unnamed_187), 2.0f, (-0.0f) - fragment_unnamed_187), fragment_unnamed_187);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Glitch, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], _Noise, fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

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
