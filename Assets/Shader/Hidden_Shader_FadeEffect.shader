Shader "Hidden/Shader/FadeEffect"
{
	Properties
	{
		_MainTex ("Main Texture", 2DArray) = "grey" {}
	}
	SubShader
	{
		Pass
		{
			Name "Depth Fade Blend"
			ZTest Always
			ZWrite Off
			Cull Off
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 29427

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


			float4 _DistanceParams;
			float4x4 _InvViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 _ScreenSize;
			float4 _RTHandleScale;
			float4 _ZBufferParams;
			float4 _ProjectionParams;

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[59];
			Texture2DArray<float4> _CameraDepthTexture;
			Texture2DArray<float4> _MainTex;
			SamplerState sampler_linear_clamp_S0;

			static float4 gl_FragCoord;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_50 = mad(gl_FragCoord.x * fragment_uniform_buffer_1[50u].z, 2.0f, -1.0f);
				float fragment_unnamed_54 = (-0.0f) - mad(gl_FragCoord.y * fragment_uniform_buffer_1[50u].w, 2.0f, -1.0f);
				float4 fragment_unnamed_84 = _CameraDepthTexture.Load(int4(uint3(uint(gl_FragCoord.x), uint(gl_FragCoord.y), 0u), 0u));
				float fragment_unnamed_87 = fragment_unnamed_84.x;
				float fragment_unnamed_122 = mad(fragment_uniform_buffer_1[30u].w, fragment_unnamed_87, mad(fragment_uniform_buffer_1[28u].w, fragment_unnamed_50, fragment_unnamed_54 * fragment_uniform_buffer_1[29u].w)) + fragment_uniform_buffer_1[31u].w;
				float fragment_unnamed_143 = ((-0.0f) - (((mad(fragment_uniform_buffer_1[30u].x, fragment_unnamed_87, mad(fragment_uniform_buffer_1[28u].x, fragment_unnamed_50, fragment_unnamed_54 * fragment_uniform_buffer_1[29u].x)) + fragment_uniform_buffer_1[31u].x) / fragment_unnamed_122) + fragment_uniform_buffer_1[48u].x)) + fragment_uniform_buffer_1[48u].x;
				float fragment_unnamed_144 = ((-0.0f) - (((mad(fragment_uniform_buffer_1[30u].y, fragment_unnamed_87, mad(fragment_uniform_buffer_1[28u].y, fragment_unnamed_50, fragment_unnamed_54 * fragment_uniform_buffer_1[29u].y)) + fragment_uniform_buffer_1[31u].y) / fragment_unnamed_122) + fragment_uniform_buffer_1[48u].y)) + fragment_uniform_buffer_1[48u].y;
				float fragment_unnamed_145 = ((-0.0f) - (((mad(fragment_uniform_buffer_1[30u].z, fragment_unnamed_87, mad(fragment_uniform_buffer_1[28u].z, fragment_unnamed_50, fragment_unnamed_54 * fragment_uniform_buffer_1[29u].z)) + fragment_uniform_buffer_1[31u].z) / fragment_unnamed_122) + fragment_uniform_buffer_1[48u].z)) + fragment_uniform_buffer_1[48u].z;
				float fragment_unnamed_169 = fragment_uniform_buffer_0[0u].x + ((-0.0f) - fragment_uniform_buffer_0[0u].y);
				float fragment_unnamed_178 = asfloat(asuint(1.0f / fragment_unnamed_169) & ((9.9999997473787516355514526367188e-05f < abs(fragment_unnamed_169)) ? 4294967295u : 0u));
				float fragment_unnamed_186 = clamp(mad((sqrt(dot(float3(fragment_unnamed_143, fragment_unnamed_144, fragment_unnamed_145), float3(fragment_unnamed_143, fragment_unnamed_144, fragment_unnamed_145))) + ((-0.0f) - fragment_uniform_buffer_1[58u].y)) + ((-0.0f) - fragment_uniform_buffer_0[0u].y), fragment_unnamed_178, fragment_unnamed_178 * ((-0.0f) - fragment_uniform_buffer_0[0u].x)), 0.0f, 1.0f);
				float fragment_unnamed_201 = min(((-0.0f) - asfloat((0.9900000095367431640625f < (1.0f / mad(fragment_uniform_buffer_1[57u].x, fragment_unnamed_87, fragment_uniform_buffer_1[57u].y))) ? asuint(mad(fragment_uniform_buffer_0[0u].w, fragment_unnamed_186 + (-1.0f), 1.0f)) : asuint(fragment_unnamed_186))) + 1.0f, fragment_uniform_buffer_0[0u].z);
				float fragment_unnamed_204 = mad(fragment_unnamed_201, ((-0.0f) - fragment_unnamed_201) + 1.0f, fragment_unnamed_201);
				float4 fragment_unnamed_222 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_input_1.x * fragment_uniform_buffer_1[52u].x, fragment_input_1.y * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
				float fragment_unnamed_227 = fragment_unnamed_222.w;
				fragment_output_0.w = mad(mad(fragment_unnamed_201, ((-0.0f) - fragment_unnamed_204) + 1.0f, fragment_unnamed_204), (-0.0f) - fragment_unnamed_227, fragment_unnamed_227);
				fragment_output_0.x = fragment_unnamed_222.x;
				fragment_output_0.y = fragment_unnamed_222.y;
				fragment_output_0.z = fragment_unnamed_222.z;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_DistanceParams[0], _DistanceParams[1], _DistanceParams[2], _DistanceParams[3]);

				fragment_uniform_buffer_1[28] = float4(_InvViewProjMatrix[0][0], _InvViewProjMatrix[1][0], _InvViewProjMatrix[2][0], _InvViewProjMatrix[3][0]);
				fragment_uniform_buffer_1[29] = float4(_InvViewProjMatrix[0][1], _InvViewProjMatrix[1][1], _InvViewProjMatrix[2][1], _InvViewProjMatrix[3][1]);
				fragment_uniform_buffer_1[30] = float4(_InvViewProjMatrix[0][2], _InvViewProjMatrix[1][2], _InvViewProjMatrix[2][2], _InvViewProjMatrix[3][2]);
				fragment_uniform_buffer_1[31] = float4(_InvViewProjMatrix[0][3], _InvViewProjMatrix[1][3], _InvViewProjMatrix[2][3], _InvViewProjMatrix[3][3]);

				fragment_uniform_buffer_1[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_1[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_1[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

				fragment_uniform_buffer_1[57] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_1[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
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
