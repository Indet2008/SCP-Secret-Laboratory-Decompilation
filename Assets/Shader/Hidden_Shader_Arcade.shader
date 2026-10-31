Shader "Hidden/Shader/Arcade"
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
			Name "Arcade"
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
			GpuProgramID 65282

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


			float _Fade;
			float4 _RTHandleScale;
			float4 _ScreenParams;
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
				float fragment_unnamed_44 = (fragment_input_1.y + (-0.5f)) * 2.2000000476837158203125f;
				float fragment_unnamed_47 = abs(fragment_unnamed_44) * 0.20000000298023223876953125f;
				float fragment_unnamed_51 = mad(fragment_unnamed_47, fragment_unnamed_47, 1.0f) * ((fragment_input_1.x + (-0.5f)) * 2.2000000476837158203125f);
				float fragment_unnamed_53 = abs(fragment_unnamed_51) * 0.25f;
				float fragment_unnamed_84 = clamp(mad(fragment_uniform_buffer_0[0u].x, mad(mad(fragment_unnamed_51, 0.5f, 0.5f), 0.920000016689300537109375f, 0.039999999105930328369140625f) + ((-0.0f) - fragment_input_1.x), fragment_input_1.x), 0.0f, 1.0f);
				float fragment_unnamed_85 = clamp(mad(fragment_uniform_buffer_0[0u].x, mad(mad(mad(fragment_unnamed_53, fragment_unnamed_53, 1.0f) * fragment_unnamed_44, 0.5f, 0.5f), 0.920000016689300537109375f, 0.039999999105930328369140625f) + ((-0.0f) - fragment_input_1.y), fragment_input_1.y), 0.0f, 1.0f);
				float fragment_unnamed_98 = exp2(log2((((-0.0f) - fragment_unnamed_85) + 1.0f) * (((fragment_unnamed_84 * fragment_unnamed_85) * 16.0f) * (((-0.0f) - fragment_unnamed_84) + 1.0f))) * 0.300000011920928955078125f);
				float4 fragment_unnamed_112 = _MainTex.Sample(sampler_linear_clamp_S0, float3((fragment_unnamed_84 + 0.001000000047497451305389404296875f) * fragment_uniform_buffer_1[52u].x, (fragment_unnamed_85 + 0.001000000047497451305389404296875f) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float fragment_unnamed_115 = fragment_unnamed_112.x;
				float fragment_unnamed_116 = fragment_unnamed_112.y;
				float fragment_unnamed_117 = fragment_unnamed_112.z;
				float fragment_unnamed_162 = mad(sin(fragment_uniform_buffer_1[76u].y * 110.0f), 0.00999999977648258209228515625f, 1.0f);
				float fragment_unnamed_170 = mad(exp2(log2(mad(sin(mad(fragment_unnamed_85 * fragment_uniform_buffer_1[61u].y, 1.5f, fragment_uniform_buffer_1[76u].y * 3.5f)), 0.3499999940395355224609375f, 0.3499999940395355224609375f)) * 1.7000000476837158203125f), 0.699999988079071044921875f, 0.4000000059604644775390625f);
				float4 fragment_unnamed_176 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_84 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_85 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float fragment_unnamed_178 = fragment_unnamed_176.x;
				float fragment_unnamed_179 = fragment_unnamed_176.y;
				float fragment_unnamed_180 = fragment_unnamed_176.z;
				fragment_output_0.x = mad(fragment_uniform_buffer_0[0u].x, mad(fragment_unnamed_170 * ((fragment_unnamed_98 * clamp(mad(fragment_unnamed_115, 0.60000002384185791015625f, (fragment_unnamed_115 * fragment_unnamed_115) * 0.4000000059604644775390625f), 0.0f, 1.0f)) * 2.6600000858306884765625f), fragment_unnamed_162, (-0.0f) - fragment_unnamed_178), fragment_unnamed_178);
				fragment_output_0.y = mad(fragment_uniform_buffer_0[0u].x, mad(fragment_unnamed_170 * ((fragment_unnamed_98 * clamp(mad(fragment_unnamed_116, 0.60000002384185791015625f, (fragment_unnamed_116 * fragment_unnamed_116) * 0.4000000059604644775390625f), 0.0f, 1.0f)) * 2.6600000858306884765625f), fragment_unnamed_162, (-0.0f) - fragment_unnamed_179), fragment_unnamed_179);
				fragment_output_0.z = mad(fragment_uniform_buffer_0[0u].x, mad(fragment_unnamed_170 * ((fragment_unnamed_98 * clamp(mad(fragment_unnamed_117, 0.60000002384185791015625f, (fragment_unnamed_117 * fragment_unnamed_117) * 0.4000000059604644775390625f), 0.0f, 1.0f)) * 2.6600000858306884765625f), fragment_unnamed_162, (-0.0f) - fragment_unnamed_180), fragment_unnamed_180);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Fade, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_1[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

				fragment_uniform_buffer_1[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

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


			float _Fade;
			float4 _RTHandleScale;
			float4 _ScreenParams;
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
				float fragment_unnamed_44 = (fragment_input_1.y + (-0.5f)) * 2.2000000476837158203125f;
				float fragment_unnamed_47 = abs(fragment_unnamed_44) * 0.20000000298023223876953125f;
				float fragment_unnamed_51 = mad(fragment_unnamed_47, fragment_unnamed_47, 1.0f) * ((fragment_input_1.x + (-0.5f)) * 2.2000000476837158203125f);
				float fragment_unnamed_53 = abs(fragment_unnamed_51) * 0.25f;
				float fragment_unnamed_84 = clamp(mad(fragment_uniform_buffer_0[0u].x, mad(mad(fragment_unnamed_51, 0.5f, 0.5f), 0.920000016689300537109375f, 0.039999999105930328369140625f) + ((-0.0f) - fragment_input_1.x), fragment_input_1.x), 0.0f, 1.0f);
				float fragment_unnamed_85 = clamp(mad(fragment_uniform_buffer_0[0u].x, mad(mad(mad(fragment_unnamed_53, fragment_unnamed_53, 1.0f) * fragment_unnamed_44, 0.5f, 0.5f), 0.920000016689300537109375f, 0.039999999105930328369140625f) + ((-0.0f) - fragment_input_1.y), fragment_input_1.y), 0.0f, 1.0f);
				float fragment_unnamed_98 = exp2(log2((((-0.0f) - fragment_unnamed_85) + 1.0f) * (((fragment_unnamed_84 * fragment_unnamed_85) * 16.0f) * (((-0.0f) - fragment_unnamed_84) + 1.0f))) * 0.300000011920928955078125f);
				float4 fragment_unnamed_112 = _MainTex.Sample(sampler_linear_clamp_S0, float3((fragment_unnamed_84 + 0.001000000047497451305389404296875f) * fragment_uniform_buffer_1[52u].x, (fragment_unnamed_85 + 0.001000000047497451305389404296875f) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float fragment_unnamed_115 = fragment_unnamed_112.x;
				float fragment_unnamed_116 = fragment_unnamed_112.y;
				float fragment_unnamed_117 = fragment_unnamed_112.z;
				float fragment_unnamed_162 = mad(sin(fragment_uniform_buffer_1[76u].y * 110.0f), 0.00999999977648258209228515625f, 1.0f);
				float fragment_unnamed_170 = mad(exp2(log2(mad(sin(mad(fragment_unnamed_85 * fragment_uniform_buffer_1[61u].y, 1.5f, fragment_uniform_buffer_1[76u].y * 3.5f)), 0.3499999940395355224609375f, 0.3499999940395355224609375f)) * 1.7000000476837158203125f), 0.699999988079071044921875f, 0.4000000059604644775390625f);
				float4 fragment_unnamed_176 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_84 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_85 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float fragment_unnamed_178 = fragment_unnamed_176.x;
				float fragment_unnamed_179 = fragment_unnamed_176.y;
				float fragment_unnamed_180 = fragment_unnamed_176.z;
				fragment_output_0.x = mad(fragment_uniform_buffer_0[0u].x, mad(fragment_unnamed_170 * ((fragment_unnamed_98 * clamp(mad(fragment_unnamed_115, 0.60000002384185791015625f, (fragment_unnamed_115 * fragment_unnamed_115) * 0.4000000059604644775390625f), 0.0f, 1.0f)) * 2.6600000858306884765625f), fragment_unnamed_162, (-0.0f) - fragment_unnamed_178), fragment_unnamed_178);
				fragment_output_0.y = mad(fragment_uniform_buffer_0[0u].x, mad(fragment_unnamed_170 * ((fragment_unnamed_98 * clamp(mad(fragment_unnamed_116, 0.60000002384185791015625f, (fragment_unnamed_116 * fragment_unnamed_116) * 0.4000000059604644775390625f), 0.0f, 1.0f)) * 2.6600000858306884765625f), fragment_unnamed_162, (-0.0f) - fragment_unnamed_179), fragment_unnamed_179);
				fragment_output_0.z = mad(fragment_uniform_buffer_0[0u].x, mad(fragment_unnamed_170 * ((fragment_unnamed_98 * clamp(mad(fragment_unnamed_117, 0.60000002384185791015625f, (fragment_unnamed_117 * fragment_unnamed_117) * 0.4000000059604644775390625f), 0.0f, 1.0f)) * 2.6600000858306884765625f), fragment_unnamed_162, (-0.0f) - fragment_unnamed_180), fragment_unnamed_180);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Fade, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_1[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

				fragment_uniform_buffer_1[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

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
