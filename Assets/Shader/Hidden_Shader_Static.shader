Shader "Hidden/Shader/Static"
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
			Name "Static"
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
			GpuProgramID 6440

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


			float _Fade;
			float _FadeAdditive;
			float _FadeDistortion;
			float4 _RTHandleScale;
			float4 _Time;

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[77];
			Texture2DArray<float4> _MainTex;
			Texture2D<float4> _StaticTex;
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
				float4 fragment_unnamed_60 = _StaticTex.Sample(sampler_linear_clamp_S1, float2(mad(fragment_uniform_buffer_1[76u].y, 10.0f, fragment_input_1.x), mad(fragment_uniform_buffer_1[76u].y, 0.5f, fragment_input_1.y)));
				float fragment_unnamed_62 = fragment_unnamed_60.x;
				float fragment_unnamed_63 = fragment_unnamed_60.y;
				float fragment_unnamed_64 = fragment_unnamed_60.z;
				float fragment_unnamed_65 = fragment_unnamed_60.w;
				float4 fragment_unnamed_84 = _MainTex.Sample(sampler_linear_clamp_S0, float3(mad(fragment_unnamed_62 * fragment_uniform_buffer_0[0u].z, 0.03125f, fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, fragment_input_1.y * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float fragment_unnamed_87 = fragment_unnamed_84.x;
				float fragment_unnamed_88 = fragment_unnamed_84.y;
				float fragment_unnamed_89 = fragment_unnamed_84.z;
				float fragment_unnamed_90 = fragment_unnamed_84.w;
				fragment_output_0.x = mad(fragment_uniform_buffer_0[0u].y, fragment_unnamed_62, mad(fragment_uniform_buffer_0[0u].x, ((-0.0f) - fragment_unnamed_87) + fragment_unnamed_62, fragment_unnamed_87));
				fragment_output_0.y = mad(fragment_uniform_buffer_0[0u].y, fragment_unnamed_63, mad(fragment_uniform_buffer_0[0u].x, ((-0.0f) - fragment_unnamed_88) + fragment_unnamed_63, fragment_unnamed_88));
				fragment_output_0.z = mad(fragment_uniform_buffer_0[0u].y, fragment_unnamed_64, mad(fragment_uniform_buffer_0[0u].x, ((-0.0f) - fragment_unnamed_89) + fragment_unnamed_64, fragment_unnamed_89));
				fragment_output_0.w = mad(fragment_uniform_buffer_0[0u].y, fragment_unnamed_65, mad(fragment_uniform_buffer_0[0u].x, ((-0.0f) - fragment_unnamed_90) + fragment_unnamed_65, fragment_unnamed_90));
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Fade, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], _FadeAdditive, fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], fragment_uniform_buffer_0[0][1], _FadeDistortion, fragment_uniform_buffer_0[0][3]);

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
