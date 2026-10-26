Shader "Hidden/Shader/SpeedLines"
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
			Name "SpeedLines"
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
			GpuProgramID 8816

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


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


			float4 _Params;
			float4 _RTHandleScale;
			float4 _Time;

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[77];
			Texture2DArray<float4> _MainTex;
			Texture2D<float4> _NoiseTex;
			SamplerState sampler_linear_clamp_S0;
			SamplerState sampler_linear_clamp_S1;

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
				float fragment_unnamed_45 = fragment_input_1.x + (-0.5f);
				float fragment_unnamed_47 = fragment_input_1.y + (-0.5f);
				float fragment_unnamed_57 = (1.0f / max(abs(fragment_unnamed_47), abs(fragment_unnamed_45))) * min(abs(fragment_unnamed_47), abs(fragment_unnamed_45));
				float fragment_unnamed_58 = fragment_unnamed_57 * fragment_unnamed_57;
				float fragment_unnamed_66 = mad(fragment_unnamed_58, mad(fragment_unnamed_58, mad(fragment_unnamed_58, mad(fragment_unnamed_58, 0.02083509974181652069091796875f, -0.08513300120830535888671875f), 0.1801410019397735595703125f), -0.33029949665069580078125f), 0.999866008758544921875f);
				float fragment_unnamed_89 = asfloat(((fragment_unnamed_47 < ((-0.0f) - fragment_unnamed_47)) ? 4294967295u : 0u) & 3226013659u) + mad(fragment_unnamed_57, fragment_unnamed_66, asfloat(((abs(fragment_unnamed_47) < abs(fragment_unnamed_45)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_66 * fragment_unnamed_57, -2.0f, 1.57079637050628662109375f))));
				float fragment_unnamed_90 = min(fragment_unnamed_47, fragment_unnamed_45);
				float fragment_unnamed_94 = max(fragment_unnamed_47, fragment_unnamed_45);
				float fragment_unnamed_137 = (((-0.0f) - frac(fragment_input_1.x)) + 0.5f) * 1.4285714626312255859375f;
				float fragment_unnamed_139 = (((-0.0f) - frac(fragment_input_1.y)) + 0.5f) * 1.4285714626312255859375f;
				float fragment_unnamed_151 = min(exp2(log2(sqrt(dot(float2(fragment_unnamed_137, fragment_unnamed_139), float2(fragment_unnamed_137, fragment_unnamed_139)))) * fragment_uniform_buffer_0[0u].y), 1.0f) * _NoiseTex.Sample(sampler_linear_clamp_S1, float2(sqrt(dot(float2(fragment_unnamed_45, fragment_unnamed_47), float2(fragment_unnamed_45, fragment_unnamed_47))) * 0.00999999977648258209228515625f, mad(mad(((((fragment_unnamed_90 < ((-0.0f) - fragment_unnamed_90)) ? 4294967295u : 0u) & ((fragment_unnamed_94 >= ((-0.0f) - fragment_unnamed_94)) ? 4294967295u : 0u)) != 0u) ? ((-0.0f) - fragment_unnamed_89) : fragment_unnamed_89, 0.159154951572418212890625f, 0.5f), fragment_uniform_buffer_0[0u].z, frac(fragment_uniform_buffer_1[76u].w)))).x;
				float4 fragment_unnamed_166 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_input_1.x * fragment_uniform_buffer_1[52u].x, fragment_input_1.y * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				fragment_output_0.x = mad(fragment_uniform_buffer_0[0u].x, fragment_unnamed_151, fragment_unnamed_166.x);
				fragment_output_0.y = mad(fragment_uniform_buffer_0[0u].x, fragment_unnamed_151, fragment_unnamed_166.y);
				fragment_output_0.z = mad(fragment_uniform_buffer_0[0u].x, fragment_unnamed_151, fragment_unnamed_166.z);
				fragment_output_0.w = fragment_unnamed_166.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				fragment_uniform_buffer_1[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

				fragment_uniform_buffer_1[76] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
	}
}
