Shader "Hidden/Shader/VignetteRefraction"
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
			Name "VignetteRefraction"
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
			GpuProgramID 13735

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


			float4 _Values;
			float4 _Color1;
			float4 _Color2;
			float4 _RTHandleScale;

			static float4 fragment_uniform_buffer_0[3];
			static float4 fragment_uniform_buffer_1[53];
			Texture2DArray<float4> _MainTex;
			Texture2D<float4> _RefractionTex;
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
				float fragment_unnamed_47 = ((-0.0f) - fragment_input_1.x) + 0.5f;
				float fragment_unnamed_49 = ((-0.0f) - fragment_input_1.y) + 0.5f;
				float fragment_unnamed_54 = sqrt(dot(float2(fragment_unnamed_47, fragment_unnamed_49), float2(fragment_unnamed_47, fragment_unnamed_49)));
				float4 fragment_unnamed_64 = _RefractionTex.Sample(sampler_linear_clamp_S0, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_66 = fragment_unnamed_64.x;
				float fragment_unnamed_67 = fragment_unnamed_64.y;
				float fragment_unnamed_74 = mad(fragment_uniform_buffer_0[0u].y, mad((-0.0f) - fragment_unnamed_54, 1.31415927410125732421875f, fragment_unnamed_66), fragment_unnamed_54 * 1.31415927410125732421875f);
				float fragment_unnamed_85 = fragment_unnamed_74 + ((-0.0f) - (((-0.0f) - fragment_uniform_buffer_0[0u].x) + 1.0f));
				float fragment_unnamed_86 = fragment_unnamed_85 / (((-0.0f) - fragment_uniform_buffer_0[0u].z) + 1.0f);
				float4 fragment_unnamed_140 = _MainTex.Sample(sampler_linear_clamp_S0, float3(mad(fragment_unnamed_66, mad(fragment_input_1.x, fragment_unnamed_66, (-0.0f) - fragment_input_1.x), fragment_input_1.x) * fragment_uniform_buffer_1[52u].x, mad(fragment_unnamed_67, mad(fragment_input_1.y, fragment_unnamed_67, (-0.0f) - fragment_input_1.y), fragment_input_1.y) * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float fragment_unnamed_146 = fragment_unnamed_140.w;
				float fragment_unnamed_147 = mad(fragment_unnamed_86, ((-0.0f) - fragment_uniform_buffer_0[1u].x) + fragment_uniform_buffer_0[2u].x, fragment_uniform_buffer_0[1u].x) + fragment_unnamed_140.x;
				float fragment_unnamed_148 = mad(fragment_unnamed_86, ((-0.0f) - fragment_uniform_buffer_0[1u].y) + fragment_uniform_buffer_0[2u].y, fragment_uniform_buffer_0[1u].y) + fragment_unnamed_140.y;
				float fragment_unnamed_149 = mad(fragment_unnamed_86, ((-0.0f) - fragment_uniform_buffer_0[1u].z) + fragment_uniform_buffer_0[2u].z, fragment_uniform_buffer_0[1u].z) + fragment_unnamed_140.z;
				float fragment_unnamed_173 = clamp((((-0.0f) - mad((-0.0f) - fragment_uniform_buffer_0[0u].z, fragment_uniform_buffer_0[0u].x, 1.0f)) + fragment_unnamed_74) / fragment_uniform_buffer_0[0u].w, 0.0f, 1.0f);
				float fragment_unnamed_174 = clamp(fragment_unnamed_85 / fragment_uniform_buffer_0[0u].w, 0.0f, 1.0f);
				float4 fragment_unnamed_190 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_input_1.x * fragment_uniform_buffer_1[52u].x, fragment_input_1.y * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float fragment_unnamed_192 = fragment_unnamed_190.x;
				float fragment_unnamed_193 = fragment_unnamed_190.y;
				float fragment_unnamed_194 = fragment_unnamed_190.z;
				float fragment_unnamed_195 = fragment_unnamed_190.w;
				fragment_output_0.x = mad(fragment_unnamed_174, mad(fragment_unnamed_173, ((-0.0f) - fragment_unnamed_147) + 1.0f, fragment_unnamed_147) + ((-0.0f) - fragment_unnamed_192), fragment_unnamed_192);
				fragment_output_0.y = mad(fragment_unnamed_174, mad(fragment_unnamed_173, ((-0.0f) - fragment_unnamed_148) + 1.0f, fragment_unnamed_148) + ((-0.0f) - fragment_unnamed_193), fragment_unnamed_193);
				fragment_output_0.z = mad(fragment_unnamed_174, mad(fragment_unnamed_173, ((-0.0f) - fragment_unnamed_149) + 1.0f, fragment_unnamed_149) + ((-0.0f) - fragment_unnamed_194), fragment_unnamed_194);
				fragment_output_0.w = mad(fragment_unnamed_174, mad(fragment_unnamed_173, ((-0.0f) - fragment_unnamed_146) + 1.0f, fragment_unnamed_146) + ((-0.0f) - fragment_unnamed_195), fragment_unnamed_195);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Values[0], _Values[1], _Values[2], _Values[3]);

				fragment_uniform_buffer_0[1] = float4(_Color1[0], _Color1[1], _Color1[2], _Color1[3]);

				fragment_uniform_buffer_0[2] = float4(_Color2[0], _Color2[1], _Color2[2], _Color2[3]);

				fragment_uniform_buffer_1[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

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
