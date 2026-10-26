Shader "02_Selection/Fullscreen"
{
	Properties
	{
		_SamplePrecision ("Sampling Precision", Range(1, 3)) = 1
		_OutlineWidth ("Outline Width", Float) = 5
		_InnerColor ("Inner Color", Color) = (1,1,0,0.5)
		_OuterColor ("Outer Color", Color) = (1,1,0,1)
		_Texture ("Texture", 2D) = "black" {}
		_TextureSize ("Texture Pixels Size", Vector) = (64,64,0,0)
		_BehindFactor ("Behind Factor", Range(0, 1)) = 0.2
	}
	SubShader
	{
		Pass
		{
			Name "Custom Pass 0"
			Blend SrcAlpha OneMinusSrcAlpha
			ZTest Always
			ZWrite Off
			Cull Off
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 27599

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			static float4 gl_Position;
			static int gl_VertexIndex;
			static int gl_BaseVertexARB;
			struct Vertex_Stage_Input
			{
				uint gl_VertexIndex : SV_VertexID;
			};

			struct Vertex_Stage_Output
			{
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
				uint vertex_unnamed_19 = 1u & 31u;
				gl_Position.x = mad(float(spvBitfieldInsert(0u, uint(gl_VertexIndex) - uint(gl_BaseVertexARB), vertex_unnamed_19, min((1u & 31u), (32u - vertex_unnamed_19)))), 2.0f, -1.0f);
				gl_Position.y = mad(float((uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) & 2u), 2.0f, -1.0f);
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				gl_VertexIndex = int(stage_input.gl_VertexIndex + 0u);
				gl_BaseVertexARB = 0u;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				return stage_output;
			}


			int _SamplePrecision;
			float _OutlineWidth;
			float4 _InnerColor;
			float4 _OuterColor;
			float2 _TextureSize;
			float _BehindFactor;
			float4 _ScreenSize;
			float4 _RTHandleScale;

			static float4 fragment_uniform_buffer_0[4];
			static float4 fragment_uniform_buffer_1[53];
			Texture2DArray<float4> _CameraDepthTexture;
			Texture2DArray<float4> _CustomDepthTexture;
			Texture2DArray<float4> _CustomColorTexture;
			Texture2D<float4> _Texture;
			SamplerState sampler_linear_clamp_S0;
			SamplerState sampler_linear_clamp_S1;

			static float4 gl_FragCoord;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				uint fragment_unnamed_37[64];
				fragment_unnamed_37[0u] = 1065353216u;
				fragment_unnamed_37[1u] = 0u;
				fragment_unnamed_37[4u] = 3212836864u;
				fragment_unnamed_37[5u] = 0u;
				fragment_unnamed_37[8u] = 0u;
				fragment_unnamed_37[9u] = 1065353216u;
				fragment_unnamed_37[12u] = 0u;
				fragment_unnamed_37[13u] = 3212836864u;
				fragment_unnamed_37[16u] = 1060439287u;
				fragment_unnamed_37[17u] = 1060439287u;
				fragment_unnamed_37[20u] = 1060439287u;
				fragment_unnamed_37[21u] = 3207922935u;
				fragment_unnamed_37[24u] = 3207922935u;
				fragment_unnamed_37[25u] = 1060439287u;
				fragment_unnamed_37[28u] = 3207922935u;
				fragment_unnamed_37[29u] = 3207922935u;
				fragment_unnamed_37[32u] = 1064076126u;
				fragment_unnamed_37[33u] = 1053028116u;
				fragment_unnamed_37[36u] = 1064076126u;
				fragment_unnamed_37[37u] = 3200511764u;
				fragment_unnamed_37[40u] = 3211559774u;
				fragment_unnamed_37[41u] = 1053028116u;
				fragment_unnamed_37[44u] = 3211559774u;
				fragment_unnamed_37[45u] = 3200511764u;
				fragment_unnamed_37[48u] = 1053028116u;
				fragment_unnamed_37[49u] = 1064076126u;
				fragment_unnamed_37[52u] = 1053028116u;
				fragment_unnamed_37[53u] = 3211559774u;
				fragment_unnamed_37[56u] = 3200511764u;
				fragment_unnamed_37[57u] = 1064076126u;
				fragment_unnamed_37[60u] = 3200511764u;
				fragment_unnamed_37[61u] = 3211559774u;
				uint fragment_unnamed_120 = uint(gl_FragCoord.x);
				uint fragment_unnamed_121 = uint(gl_FragCoord.y);
				float4 fragment_unnamed_140 = _CustomColorTexture.Load(int4(uint3(fragment_unnamed_120, fragment_unnamed_121, 0u), 0u));
				float fragment_unnamed_145 = fragment_unnamed_140.w;
				float fragment_unnamed_152 = exp2(float(int(asuint(fragment_uniform_buffer_0[0u]).z)));
				uint fragment_unnamed_156 = uint(min(fragment_unnamed_152 + fragment_unnamed_152, 16.0f));
				float fragment_unnamed_168 = (1.0f / fragment_uniform_buffer_1[50u].x) * fragment_uniform_buffer_0[0u].w;
				float fragment_unnamed_169 = (1.0f / fragment_uniform_buffer_1[50u].y) * fragment_uniform_buffer_0[0u].w;
				float fragment_unnamed_170 = asfloat(0u);
				uint fragment_unnamed_173;
				uint fragment_unnamed_175;
				uint fragment_unnamed_177;
				float fragment_unnamed_179;
				fragment_unnamed_173 = 0u;
				fragment_unnamed_175 = 0u;
				fragment_unnamed_177 = 0u;
				fragment_unnamed_179 = asfloat(0u);
				uint fragment_unnamed_250;
				float4 fragment_unnamed_279;
				for (uint fragment_unnamed_181 = 0u; !(fragment_unnamed_181 >= fragment_unnamed_156); fragment_unnamed_250 = fragment_unnamed_181 * 4u, fragment_unnamed_279 = _CustomColorTexture.SampleLevel(sampler_linear_clamp_S0, float3(mad(gl_FragCoord.x, fragment_uniform_buffer_1[50u].z, fragment_unnamed_168 * asfloat(fragment_unnamed_37[fragment_unnamed_250 + 0u])) * fragment_uniform_buffer_1[52u].x, mad(gl_FragCoord.y, fragment_uniform_buffer_1[50u].w, fragment_unnamed_169 * asfloat(fragment_unnamed_37[fragment_unnamed_250 + 1u])) * fragment_uniform_buffer_1[52u].y, fragment_unnamed_170), 0.0f), fragment_unnamed_173 = asuint(max(asfloat(fragment_unnamed_173), fragment_unnamed_279.x)), fragment_unnamed_175 = asuint(max(asfloat(fragment_unnamed_175), fragment_unnamed_279.y)), fragment_unnamed_177 = asuint(max(asfloat(fragment_unnamed_177), fragment_unnamed_279.z)), fragment_unnamed_179 = max(fragment_unnamed_179, fragment_unnamed_279.w), fragment_unnamed_181++)
				{
				}
				float4 fragment_unnamed_195 = _Texture.Sample(sampler_linear_clamp_S1, float2(float(fragment_unnamed_120) / fragment_uniform_buffer_0[3u].x, float(fragment_unnamed_121) / fragment_uniform_buffer_0[3u].y));
				float fragment_unnamed_228 = (asfloat(fragment_unnamed_173) * fragment_uniform_buffer_0[2u].x) * fragment_unnamed_179;
				float fragment_unnamed_229 = (asfloat(fragment_unnamed_175) * fragment_uniform_buffer_0[2u].y) * fragment_unnamed_179;
				float fragment_unnamed_230 = (asfloat(fragment_unnamed_177) * fragment_uniform_buffer_0[2u].z) * fragment_unnamed_179;
				float fragment_unnamed_231 = (asfloat(1065353216u) * fragment_uniform_buffer_0[2u].w) * fragment_unnamed_179;
				fragment_output_0.x = mad(fragment_unnamed_145, mad(fragment_unnamed_195.x * fragment_uniform_buffer_0[1u].x, fragment_unnamed_140.x, (-0.0f) - fragment_unnamed_228), fragment_unnamed_228);
				fragment_output_0.y = mad(fragment_unnamed_145, mad(fragment_unnamed_195.y * fragment_uniform_buffer_0[1u].y, fragment_unnamed_140.y, (-0.0f) - fragment_unnamed_229), fragment_unnamed_229);
				fragment_output_0.z = mad(fragment_unnamed_145, mad(fragment_unnamed_195.z * fragment_uniform_buffer_0[1u].z, fragment_unnamed_140.z, (-0.0f) - fragment_unnamed_230), fragment_unnamed_230);
				fragment_output_0.w = mad(fragment_unnamed_145, mad(asfloat((_CustomDepthTexture.Load(int4(uint3(fragment_unnamed_120, fragment_unnamed_121, 0u), 0u)).x < _CameraDepthTexture.Load(int4(uint3(fragment_unnamed_120, fragment_unnamed_121, 0u), 0u)).x) ? asuint(fragment_uniform_buffer_0[3u]).z : 1065353216u) * (fragment_unnamed_195.w * fragment_uniform_buffer_0[1u].w), asfloat(1065353216u), (-0.0f) - fragment_unnamed_231), fragment_unnamed_231);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], fragment_uniform_buffer_0[0][1], asfloat(_SamplePrecision), fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], _OutlineWidth);

				fragment_uniform_buffer_0[1] = float4(_InnerColor[0], _InnerColor[1], _InnerColor[2], _InnerColor[3]);

				fragment_uniform_buffer_0[2] = float4(_OuterColor[0], _OuterColor[1], _OuterColor[2], _OuterColor[3]);

				fragment_uniform_buffer_0[3] = float4(_TextureSize[0], _TextureSize[1], fragment_uniform_buffer_0[3][2], fragment_uniform_buffer_0[3][3]);

				fragment_uniform_buffer_0[3] = float4(fragment_uniform_buffer_0[3][0], fragment_uniform_buffer_0[3][1], _BehindFactor, fragment_uniform_buffer_0[3][3]);

				fragment_uniform_buffer_1[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_1[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
	}
}
