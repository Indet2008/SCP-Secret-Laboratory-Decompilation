Shader "Hidden/Shader/BlurEffect"
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
			Name "Blur Blend"
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
			GpuProgramID 33575

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


			float4 _RTHandleScale;

			static float4 fragment_uniform_buffer_0[53];
			Texture2DArray<float4> _BlurredTex;
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
				float4 fragment_unnamed_47 = _BlurredTex.Sample(sampler_linear_clamp_S0, float3(fragment_input_1.x * fragment_uniform_buffer_0[52u].x, fragment_input_1.y * fragment_uniform_buffer_0[52u].y, asfloat(0u)));
				fragment_output_0.x = fragment_unnamed_47.x;
				fragment_output_0.y = fragment_unnamed_47.y;
				fragment_output_0.z = fragment_unnamed_47.z;
				fragment_output_0.w = fragment_unnamed_47.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

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


			float4 _RTHandleScale;

			static float4 fragment_uniform_buffer_0[53];
			Texture2DArray<float4> _BlurredTex;
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
				float4 fragment_unnamed_47 = _BlurredTex.Sample(sampler_linear_clamp_S0, float3(fragment_input_1.x * fragment_uniform_buffer_0[52u].x, fragment_input_1.y * fragment_uniform_buffer_0[52u].y, asfloat(0u)));
				fragment_output_0.x = fragment_unnamed_47.x;
				fragment_output_0.y = fragment_unnamed_47.y;
				fragment_output_0.z = fragment_unnamed_47.z;
				fragment_output_0.w = fragment_unnamed_47.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

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
			Name "Depth Fade Blend"
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
			GpuProgramID 122328

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
			Texture2DArray<float4> _BlurredTex;
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
				float fragment_unnamed_52 = mad(gl_FragCoord.x * fragment_uniform_buffer_1[50u].z, 2.0f, -1.0f);
				float fragment_unnamed_56 = (-0.0f) - mad(gl_FragCoord.y * fragment_uniform_buffer_1[50u].w, 2.0f, -1.0f);
				float4 fragment_unnamed_86 = _CameraDepthTexture.Load(int4(uint3(uint(gl_FragCoord.x), uint(gl_FragCoord.y), 0u), 0u));
				float fragment_unnamed_89 = fragment_unnamed_86.x;
				float fragment_unnamed_124 = mad(fragment_uniform_buffer_1[30u].w, fragment_unnamed_89, mad(fragment_uniform_buffer_1[28u].w, fragment_unnamed_52, fragment_unnamed_56 * fragment_uniform_buffer_1[29u].w)) + fragment_uniform_buffer_1[31u].w;
				float fragment_unnamed_145 = ((-0.0f) - (((mad(fragment_uniform_buffer_1[30u].x, fragment_unnamed_89, mad(fragment_uniform_buffer_1[28u].x, fragment_unnamed_52, fragment_unnamed_56 * fragment_uniform_buffer_1[29u].x)) + fragment_uniform_buffer_1[31u].x) / fragment_unnamed_124) + fragment_uniform_buffer_1[48u].x)) + fragment_uniform_buffer_1[48u].x;
				float fragment_unnamed_146 = ((-0.0f) - (((mad(fragment_uniform_buffer_1[30u].y, fragment_unnamed_89, mad(fragment_uniform_buffer_1[28u].y, fragment_unnamed_52, fragment_unnamed_56 * fragment_uniform_buffer_1[29u].y)) + fragment_uniform_buffer_1[31u].y) / fragment_unnamed_124) + fragment_uniform_buffer_1[48u].y)) + fragment_uniform_buffer_1[48u].y;
				float fragment_unnamed_147 = ((-0.0f) - (((mad(fragment_uniform_buffer_1[30u].z, fragment_unnamed_89, mad(fragment_uniform_buffer_1[28u].z, fragment_unnamed_52, fragment_unnamed_56 * fragment_uniform_buffer_1[29u].z)) + fragment_uniform_buffer_1[31u].z) / fragment_unnamed_124) + fragment_uniform_buffer_1[48u].z)) + fragment_uniform_buffer_1[48u].z;
				float fragment_unnamed_171 = fragment_uniform_buffer_0[0u].x + ((-0.0f) - fragment_uniform_buffer_0[0u].y);
				float fragment_unnamed_180 = asfloat(asuint(1.0f / fragment_unnamed_171) & ((9.9999997473787516355514526367188e-05f < abs(fragment_unnamed_171)) ? 4294967295u : 0u));
				float fragment_unnamed_188 = clamp(mad((sqrt(dot(float3(fragment_unnamed_145, fragment_unnamed_146, fragment_unnamed_147), float3(fragment_unnamed_145, fragment_unnamed_146, fragment_unnamed_147))) + ((-0.0f) - fragment_uniform_buffer_1[58u].y)) + ((-0.0f) - fragment_uniform_buffer_0[0u].y), fragment_unnamed_180, fragment_unnamed_180 * ((-0.0f) - fragment_uniform_buffer_0[0u].x)), 0.0f, 1.0f);
				float fragment_unnamed_203 = min(((-0.0f) - asfloat((0.9900000095367431640625f < (1.0f / mad(fragment_uniform_buffer_1[57u].x, fragment_unnamed_89, fragment_uniform_buffer_1[57u].y))) ? asuint(mad(fragment_uniform_buffer_0[0u].w, fragment_unnamed_188 + (-1.0f), 1.0f)) : asuint(fragment_unnamed_188))) + 1.0f, fragment_uniform_buffer_0[0u].z);
				float fragment_unnamed_213 = fragment_input_1.x * fragment_uniform_buffer_1[52u].x;
				float fragment_unnamed_214 = fragment_input_1.y * fragment_uniform_buffer_1[52u].y;
				float fragment_unnamed_215 = asfloat(0u);
				float4 fragment_unnamed_218 = _BlurredTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_213, fragment_unnamed_214, fragment_unnamed_215));
				float4 fragment_unnamed_225 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_213, fragment_unnamed_214, fragment_unnamed_215));
				float fragment_unnamed_227 = fragment_unnamed_225.x;
				float fragment_unnamed_228 = fragment_unnamed_225.y;
				float fragment_unnamed_229 = fragment_unnamed_225.z;
				fragment_output_0.w = max(fragment_unnamed_225.w, fragment_unnamed_218.w);
				fragment_output_0.x = mad(fragment_unnamed_203, ((-0.0f) - fragment_unnamed_227) + fragment_unnamed_218.x, fragment_unnamed_227);
				fragment_output_0.y = mad(fragment_unnamed_203, ((-0.0f) - fragment_unnamed_228) + fragment_unnamed_218.y, fragment_unnamed_228);
				fragment_output_0.z = mad(fragment_unnamed_203, ((-0.0f) - fragment_unnamed_229) + fragment_unnamed_218.z, fragment_unnamed_229);
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
			Texture2DArray<float4> _BlurredTex;
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
				float fragment_unnamed_52 = mad(gl_FragCoord.x * fragment_uniform_buffer_1[50u].z, 2.0f, -1.0f);
				float fragment_unnamed_56 = (-0.0f) - mad(gl_FragCoord.y * fragment_uniform_buffer_1[50u].w, 2.0f, -1.0f);
				float4 fragment_unnamed_86 = _CameraDepthTexture.Load(int4(uint3(uint(gl_FragCoord.x), uint(gl_FragCoord.y), 0u), 0u));
				float fragment_unnamed_89 = fragment_unnamed_86.x;
				float fragment_unnamed_124 = mad(fragment_uniform_buffer_1[30u].w, fragment_unnamed_89, mad(fragment_uniform_buffer_1[28u].w, fragment_unnamed_52, fragment_unnamed_56 * fragment_uniform_buffer_1[29u].w)) + fragment_uniform_buffer_1[31u].w;
				float fragment_unnamed_145 = ((-0.0f) - (((mad(fragment_uniform_buffer_1[30u].x, fragment_unnamed_89, mad(fragment_uniform_buffer_1[28u].x, fragment_unnamed_52, fragment_unnamed_56 * fragment_uniform_buffer_1[29u].x)) + fragment_uniform_buffer_1[31u].x) / fragment_unnamed_124) + fragment_uniform_buffer_1[48u].x)) + fragment_uniform_buffer_1[48u].x;
				float fragment_unnamed_146 = ((-0.0f) - (((mad(fragment_uniform_buffer_1[30u].y, fragment_unnamed_89, mad(fragment_uniform_buffer_1[28u].y, fragment_unnamed_52, fragment_unnamed_56 * fragment_uniform_buffer_1[29u].y)) + fragment_uniform_buffer_1[31u].y) / fragment_unnamed_124) + fragment_uniform_buffer_1[48u].y)) + fragment_uniform_buffer_1[48u].y;
				float fragment_unnamed_147 = ((-0.0f) - (((mad(fragment_uniform_buffer_1[30u].z, fragment_unnamed_89, mad(fragment_uniform_buffer_1[28u].z, fragment_unnamed_52, fragment_unnamed_56 * fragment_uniform_buffer_1[29u].z)) + fragment_uniform_buffer_1[31u].z) / fragment_unnamed_124) + fragment_uniform_buffer_1[48u].z)) + fragment_uniform_buffer_1[48u].z;
				float fragment_unnamed_171 = fragment_uniform_buffer_0[0u].x + ((-0.0f) - fragment_uniform_buffer_0[0u].y);
				float fragment_unnamed_180 = asfloat(asuint(1.0f / fragment_unnamed_171) & ((9.9999997473787516355514526367188e-05f < abs(fragment_unnamed_171)) ? 4294967295u : 0u));
				float fragment_unnamed_188 = clamp(mad((sqrt(dot(float3(fragment_unnamed_145, fragment_unnamed_146, fragment_unnamed_147), float3(fragment_unnamed_145, fragment_unnamed_146, fragment_unnamed_147))) + ((-0.0f) - fragment_uniform_buffer_1[58u].y)) + ((-0.0f) - fragment_uniform_buffer_0[0u].y), fragment_unnamed_180, fragment_unnamed_180 * ((-0.0f) - fragment_uniform_buffer_0[0u].x)), 0.0f, 1.0f);
				float fragment_unnamed_203 = min(((-0.0f) - asfloat((0.9900000095367431640625f < (1.0f / mad(fragment_uniform_buffer_1[57u].x, fragment_unnamed_89, fragment_uniform_buffer_1[57u].y))) ? asuint(mad(fragment_uniform_buffer_0[0u].w, fragment_unnamed_188 + (-1.0f), 1.0f)) : asuint(fragment_unnamed_188))) + 1.0f, fragment_uniform_buffer_0[0u].z);
				float fragment_unnamed_213 = fragment_input_1.x * fragment_uniform_buffer_1[52u].x;
				float fragment_unnamed_214 = fragment_input_1.y * fragment_uniform_buffer_1[52u].y;
				float fragment_unnamed_215 = asfloat(0u);
				float4 fragment_unnamed_218 = _BlurredTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_213, fragment_unnamed_214, fragment_unnamed_215));
				float4 fragment_unnamed_225 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_213, fragment_unnamed_214, fragment_unnamed_215));
				float fragment_unnamed_227 = fragment_unnamed_225.x;
				float fragment_unnamed_228 = fragment_unnamed_225.y;
				float fragment_unnamed_229 = fragment_unnamed_225.z;
				fragment_output_0.w = max(fragment_unnamed_225.w, fragment_unnamed_218.w);
				fragment_output_0.x = mad(fragment_unnamed_203, ((-0.0f) - fragment_unnamed_227) + fragment_unnamed_218.x, fragment_unnamed_227);
				fragment_output_0.y = mad(fragment_unnamed_203, ((-0.0f) - fragment_unnamed_228) + fragment_unnamed_218.y, fragment_unnamed_228);
				fragment_output_0.z = mad(fragment_unnamed_203, ((-0.0f) - fragment_unnamed_229) + fragment_unnamed_218.z, fragment_unnamed_229);
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
			Name "Gaussian Blur"
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
			GpuProgramID 155042

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			#if defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT
			float4 _BlurOffsets;
			float4 _BlitScaleBias;

			static float4 vertex_uniform_buffer_0[3];
			static float4 gl_Position;
			static int gl_VertexIndex;
			static int gl_BaseVertexARB;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				uint gl_VertexIndex : SV_VertexID;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
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
				uint vertex_unnamed_30 = 1u & 31u;
				float vertex_unnamed_42 = float(spvBitfieldInsert(0u, uint(gl_VertexIndex) - uint(gl_BaseVertexARB), vertex_unnamed_30, min((1u & 31u), (32u - vertex_unnamed_30))));
				float vertex_unnamed_43 = float((uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) & 2u);
				gl_Position.x = mad(vertex_unnamed_42, 2.0f, -1.0f);
				gl_Position.y = mad(vertex_unnamed_43, 2.0f, -1.0f);
				float vertex_unnamed_64 = mad(vertex_unnamed_42, vertex_uniform_buffer_0[2u].x, vertex_uniform_buffer_0[2u].z);
				float vertex_unnamed_65 = mad(((-0.0f) - vertex_unnamed_43) + 1.0f, vertex_uniform_buffer_0[2u].y, vertex_uniform_buffer_0[2u].w);
				gl_Position.z = 1.0f;
				gl_Position.w = 1.0f;
				vertex_output_1.x = vertex_unnamed_64;
				vertex_output_1.y = vertex_unnamed_65;
				vertex_output_2.x = mad(vertex_uniform_buffer_0[1u].x, 1.0f, vertex_unnamed_64);
				vertex_output_2.y = mad(vertex_uniform_buffer_0[1u].y, 1.0f, vertex_unnamed_65);
				vertex_output_2.z = mad(vertex_uniform_buffer_0[1u].x, -1.0f, vertex_unnamed_64);
				vertex_output_2.w = mad(vertex_uniform_buffer_0[1u].y, -1.0f, vertex_unnamed_65);
				vertex_output_3.x = mad(vertex_uniform_buffer_0[1u].x, 2.0f, vertex_unnamed_64);
				vertex_output_3.y = mad(vertex_uniform_buffer_0[1u].y, 2.0f, vertex_unnamed_65);
				vertex_output_3.z = mad(vertex_uniform_buffer_0[1u].x, -2.0f, vertex_unnamed_64);
				vertex_output_3.w = mad(vertex_uniform_buffer_0[1u].y, -2.0f, vertex_unnamed_65);
				vertex_output_4.x = mad(vertex_uniform_buffer_0[1u].x, 6.0f, vertex_unnamed_64);
				vertex_output_4.y = mad(vertex_uniform_buffer_0[1u].y, 6.0f, vertex_unnamed_65);
				vertex_output_4.z = mad(vertex_uniform_buffer_0[1u].x, -6.0f, vertex_unnamed_64);
				vertex_output_4.w = mad(vertex_uniform_buffer_0[1u].y, -6.0f, vertex_unnamed_65);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[1] = float4(_BlurOffsets[0], _BlurOffsets[1], _BlurOffsets[2], _BlurOffsets[3]);

				vertex_uniform_buffer_0[2] = float4(_BlitScaleBias[0], _BlitScaleBias[1], _BlitScaleBias[2], _BlitScaleBias[3]);

				gl_VertexIndex = int(stage_input.gl_VertexIndex + 0u);
				gl_BaseVertexARB = 0u;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			Texture2DArray<float4> _BlitTexture;
			SamplerState sampler_linear_clamp_S0;

			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float4 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_37 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(fragment_input_2.x, fragment_input_2.y, asfloat(0u)));
				float4 fragment_unnamed_54 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(fragment_input_1.x, fragment_input_1.y, asfloat(0u)));
				float4 fragment_unnamed_73 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(fragment_input_2.z, fragment_input_2.w, asfloat(0u)));
				float4 fragment_unnamed_88 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(fragment_input_3.x, fragment_input_3.y, asfloat(0u)));
				float4 fragment_unnamed_104 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(fragment_input_3.z, fragment_input_3.w, asfloat(0u)));
				float4 fragment_unnamed_119 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(fragment_input_4.x, fragment_input_4.y, asfloat(0u)));
				float4 fragment_unnamed_135 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(fragment_input_4.z, fragment_input_4.w, asfloat(0u)));
				fragment_output_0.x = mad(fragment_unnamed_135.x, 0.0500000007450580596923828125f, mad(fragment_unnamed_119.x, 0.0500000007450580596923828125f, mad(fragment_unnamed_104.x, 0.100000001490116119384765625f, mad(fragment_unnamed_88.x, 0.100000001490116119384765625f, mad(fragment_unnamed_73.x, 0.1500000059604644775390625f, mad(fragment_unnamed_54.x, 0.4000000059604644775390625f, fragment_unnamed_37.x * 0.1500000059604644775390625f))))));
				fragment_output_0.y = mad(fragment_unnamed_135.y, 0.0500000007450580596923828125f, mad(fragment_unnamed_119.y, 0.0500000007450580596923828125f, mad(fragment_unnamed_104.y, 0.100000001490116119384765625f, mad(fragment_unnamed_88.y, 0.100000001490116119384765625f, mad(fragment_unnamed_73.y, 0.1500000059604644775390625f, mad(fragment_unnamed_54.y, 0.4000000059604644775390625f, fragment_unnamed_37.y * 0.1500000059604644775390625f))))));
				fragment_output_0.z = mad(fragment_unnamed_135.z, 0.0500000007450580596923828125f, mad(fragment_unnamed_119.z, 0.0500000007450580596923828125f, mad(fragment_unnamed_104.z, 0.100000001490116119384765625f, mad(fragment_unnamed_88.z, 0.100000001490116119384765625f, mad(fragment_unnamed_73.z, 0.1500000059604644775390625f, mad(fragment_unnamed_54.z, 0.4000000059604644775390625f, fragment_unnamed_37.z * 0.1500000059604644775390625f))))));
				fragment_output_0.w = mad(fragment_unnamed_135.w, 0.0500000007450580596923828125f, mad(fragment_unnamed_119.w, 0.0500000007450580596923828125f, mad(fragment_unnamed_104.w, 0.100000001490116119384765625f, mad(fragment_unnamed_88.w, 0.100000001490116119384765625f, mad(fragment_unnamed_73.w, 0.1500000059604644775390625f, mad(fragment_unnamed_54.w, 0.4000000059604644775390625f, fragment_unnamed_37.w * 0.1500000059604644775390625f))))));
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}



			#endif
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			#define RIP_HAS_VERT
			float4 _BlurOffsets;
			float4 _BlitScaleBias;

			static float4 vertex_uniform_buffer_0[3];
			static float4 gl_Position;
			static int gl_VertexIndex;
			static int gl_BaseVertexARB;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				uint gl_VertexIndex : SV_VertexID;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
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
				uint vertex_unnamed_30 = 1u & 31u;
				float vertex_unnamed_42 = float(spvBitfieldInsert(0u, uint(gl_VertexIndex) - uint(gl_BaseVertexARB), vertex_unnamed_30, min((1u & 31u), (32u - vertex_unnamed_30))));
				float vertex_unnamed_43 = float((uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) & 2u);
				gl_Position.x = mad(vertex_unnamed_42, 2.0f, -1.0f);
				gl_Position.y = mad(vertex_unnamed_43, 2.0f, -1.0f);
				float vertex_unnamed_64 = mad(vertex_unnamed_42, vertex_uniform_buffer_0[2u].x, vertex_uniform_buffer_0[2u].z);
				float vertex_unnamed_65 = mad(((-0.0f) - vertex_unnamed_43) + 1.0f, vertex_uniform_buffer_0[2u].y, vertex_uniform_buffer_0[2u].w);
				gl_Position.z = 1.0f;
				gl_Position.w = 1.0f;
				vertex_output_1.x = vertex_unnamed_64;
				vertex_output_1.y = vertex_unnamed_65;
				vertex_output_2.x = mad(vertex_uniform_buffer_0[1u].x, 1.0f, vertex_unnamed_64);
				vertex_output_2.y = mad(vertex_uniform_buffer_0[1u].y, 1.0f, vertex_unnamed_65);
				vertex_output_2.z = mad(vertex_uniform_buffer_0[1u].x, -1.0f, vertex_unnamed_64);
				vertex_output_2.w = mad(vertex_uniform_buffer_0[1u].y, -1.0f, vertex_unnamed_65);
				vertex_output_3.x = mad(vertex_uniform_buffer_0[1u].x, 2.0f, vertex_unnamed_64);
				vertex_output_3.y = mad(vertex_uniform_buffer_0[1u].y, 2.0f, vertex_unnamed_65);
				vertex_output_3.z = mad(vertex_uniform_buffer_0[1u].x, -2.0f, vertex_unnamed_64);
				vertex_output_3.w = mad(vertex_uniform_buffer_0[1u].y, -2.0f, vertex_unnamed_65);
				vertex_output_4.x = mad(vertex_uniform_buffer_0[1u].x, 6.0f, vertex_unnamed_64);
				vertex_output_4.y = mad(vertex_uniform_buffer_0[1u].y, 6.0f, vertex_unnamed_65);
				vertex_output_4.z = mad(vertex_uniform_buffer_0[1u].x, -6.0f, vertex_unnamed_64);
				vertex_output_4.w = mad(vertex_uniform_buffer_0[1u].y, -6.0f, vertex_unnamed_65);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[1] = float4(_BlurOffsets[0], _BlurOffsets[1], _BlurOffsets[2], _BlurOffsets[3]);

				vertex_uniform_buffer_0[2] = float4(_BlitScaleBias[0], _BlitScaleBias[1], _BlitScaleBias[2], _BlitScaleBias[3]);

				gl_VertexIndex = int(stage_input.gl_VertexIndex + 0u);
				gl_BaseVertexARB = 0u;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			#define RIP_HAS_FRAG


			Texture2DArray<float4> _BlitTexture;
			SamplerState sampler_linear_clamp_S0;

			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float4 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_37 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(fragment_input_2.x, fragment_input_2.y, asfloat(0u)));
				float4 fragment_unnamed_54 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(fragment_input_1.x, fragment_input_1.y, asfloat(0u)));
				float4 fragment_unnamed_73 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(fragment_input_2.z, fragment_input_2.w, asfloat(0u)));
				float4 fragment_unnamed_88 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(fragment_input_3.x, fragment_input_3.y, asfloat(0u)));
				float4 fragment_unnamed_104 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(fragment_input_3.z, fragment_input_3.w, asfloat(0u)));
				float4 fragment_unnamed_119 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(fragment_input_4.x, fragment_input_4.y, asfloat(0u)));
				float4 fragment_unnamed_135 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(fragment_input_4.z, fragment_input_4.w, asfloat(0u)));
				fragment_output_0.x = mad(fragment_unnamed_135.x, 0.0500000007450580596923828125f, mad(fragment_unnamed_119.x, 0.0500000007450580596923828125f, mad(fragment_unnamed_104.x, 0.100000001490116119384765625f, mad(fragment_unnamed_88.x, 0.100000001490116119384765625f, mad(fragment_unnamed_73.x, 0.1500000059604644775390625f, mad(fragment_unnamed_54.x, 0.4000000059604644775390625f, fragment_unnamed_37.x * 0.1500000059604644775390625f))))));
				fragment_output_0.y = mad(fragment_unnamed_135.y, 0.0500000007450580596923828125f, mad(fragment_unnamed_119.y, 0.0500000007450580596923828125f, mad(fragment_unnamed_104.y, 0.100000001490116119384765625f, mad(fragment_unnamed_88.y, 0.100000001490116119384765625f, mad(fragment_unnamed_73.y, 0.1500000059604644775390625f, mad(fragment_unnamed_54.y, 0.4000000059604644775390625f, fragment_unnamed_37.y * 0.1500000059604644775390625f))))));
				fragment_output_0.z = mad(fragment_unnamed_135.z, 0.0500000007450580596923828125f, mad(fragment_unnamed_119.z, 0.0500000007450580596923828125f, mad(fragment_unnamed_104.z, 0.100000001490116119384765625f, mad(fragment_unnamed_88.z, 0.100000001490116119384765625f, mad(fragment_unnamed_73.z, 0.1500000059604644775390625f, mad(fragment_unnamed_54.z, 0.4000000059604644775390625f, fragment_unnamed_37.z * 0.1500000059604644775390625f))))));
				fragment_output_0.w = mad(fragment_unnamed_135.w, 0.0500000007450580596923828125f, mad(fragment_unnamed_119.w, 0.0500000007450580596923828125f, mad(fragment_unnamed_104.w, 0.100000001490116119384765625f, mad(fragment_unnamed_88.w, 0.100000001490116119384765625f, mad(fragment_unnamed_73.w, 0.1500000059604644775390625f, mad(fragment_unnamed_54.w, 0.4000000059604644775390625f, fragment_unnamed_37.w * 0.1500000059604644775390625f))))));
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			Name "Box Blur"
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
			GpuProgramID 219952

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			#if defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT
			float4 _BlitScaleBias;

			static float4 vertex_uniform_buffer_0[3];
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
				uint vertex_unnamed_27 = 1u & 31u;
				float vertex_unnamed_39 = float(spvBitfieldInsert(0u, uint(gl_VertexIndex) - uint(gl_BaseVertexARB), vertex_unnamed_27, min((1u & 31u), (32u - vertex_unnamed_27))));
				float vertex_unnamed_40 = float((uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) & 2u);
				gl_Position.x = mad(vertex_unnamed_39, 2.0f, -1.0f);
				gl_Position.y = mad(vertex_unnamed_40, 2.0f, -1.0f);
				vertex_output_1.x = mad(vertex_unnamed_39, vertex_uniform_buffer_0[2u].x, vertex_uniform_buffer_0[2u].z);
				vertex_output_1.y = mad(((-0.0f) - vertex_unnamed_40) + 1.0f, vertex_uniform_buffer_0[2u].y, vertex_uniform_buffer_0[2u].w);
				gl_Position.z = 1.0f;
				gl_Position.w = 1.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_BlitScaleBias[0], _BlitScaleBias[1], _BlitScaleBias[2], _BlitScaleBias[3]);

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


			float4 _BlurOffsets;

			static float4 fragment_uniform_buffer_0[2];
			Texture2DArray<float4> _BlitTexture;
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
				float4 fragment_unnamed_51 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(mad(fragment_uniform_buffer_0[1u].x, -1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[1u].y, -1.0f, fragment_input_1.y), asfloat(0u)));
				float4 fragment_unnamed_59 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(mad(fragment_uniform_buffer_0[1u].x, 1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[1u].y, -1.0f, fragment_input_1.y), asfloat(0u)));
				float4 fragment_unnamed_82 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(mad(fragment_uniform_buffer_0[1u].x, -1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[1u].y, 1.0f, fragment_input_1.y), asfloat(0u)));
				float4 fragment_unnamed_93 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(mad(fragment_uniform_buffer_0[1u].x, 1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[1u].y, 1.0f, fragment_input_1.y), asfloat(0u)));
				fragment_output_0.x = (((fragment_unnamed_51.x + fragment_unnamed_59.x) + fragment_unnamed_82.x) + fragment_unnamed_93.x) * 0.25f;
				fragment_output_0.y = (((fragment_unnamed_51.y + fragment_unnamed_59.y) + fragment_unnamed_82.y) + fragment_unnamed_93.y) * 0.25f;
				fragment_output_0.z = (((fragment_unnamed_51.z + fragment_unnamed_59.z) + fragment_unnamed_82.z) + fragment_unnamed_93.z) * 0.25f;
				fragment_output_0.w = (((fragment_unnamed_51.w + fragment_unnamed_59.w) + fragment_unnamed_82.w) + fragment_unnamed_93.w) * 0.25f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[1] = float4(_BlurOffsets[0], _BlurOffsets[1], _BlurOffsets[2], _BlurOffsets[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}



			#endif
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			#define RIP_HAS_VERT
			float4 _BlitScaleBias;

			static float4 vertex_uniform_buffer_0[3];
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
				uint vertex_unnamed_27 = 1u & 31u;
				float vertex_unnamed_39 = float(spvBitfieldInsert(0u, uint(gl_VertexIndex) - uint(gl_BaseVertexARB), vertex_unnamed_27, min((1u & 31u), (32u - vertex_unnamed_27))));
				float vertex_unnamed_40 = float((uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) & 2u);
				gl_Position.x = mad(vertex_unnamed_39, 2.0f, -1.0f);
				gl_Position.y = mad(vertex_unnamed_40, 2.0f, -1.0f);
				vertex_output_1.x = mad(vertex_unnamed_39, vertex_uniform_buffer_0[2u].x, vertex_uniform_buffer_0[2u].z);
				vertex_output_1.y = mad(((-0.0f) - vertex_unnamed_40) + 1.0f, vertex_uniform_buffer_0[2u].y, vertex_uniform_buffer_0[2u].w);
				gl_Position.z = 1.0f;
				gl_Position.w = 1.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_BlitScaleBias[0], _BlitScaleBias[1], _BlitScaleBias[2], _BlitScaleBias[3]);

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


			float4 _BlurOffsets;

			static float4 fragment_uniform_buffer_0[2];
			Texture2DArray<float4> _BlitTexture;
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
				float4 fragment_unnamed_51 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(mad(fragment_uniform_buffer_0[1u].x, -1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[1u].y, -1.0f, fragment_input_1.y), asfloat(0u)));
				float4 fragment_unnamed_59 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(mad(fragment_uniform_buffer_0[1u].x, 1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[1u].y, -1.0f, fragment_input_1.y), asfloat(0u)));
				float4 fragment_unnamed_82 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(mad(fragment_uniform_buffer_0[1u].x, -1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[1u].y, 1.0f, fragment_input_1.y), asfloat(0u)));
				float4 fragment_unnamed_93 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(mad(fragment_uniform_buffer_0[1u].x, 1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[1u].y, 1.0f, fragment_input_1.y), asfloat(0u)));
				fragment_output_0.x = (((fragment_unnamed_51.x + fragment_unnamed_59.x) + fragment_unnamed_82.x) + fragment_unnamed_93.x) * 0.25f;
				fragment_output_0.y = (((fragment_unnamed_51.y + fragment_unnamed_59.y) + fragment_unnamed_82.y) + fragment_unnamed_93.y) * 0.25f;
				fragment_output_0.z = (((fragment_unnamed_51.z + fragment_unnamed_59.z) + fragment_unnamed_82.z) + fragment_unnamed_93.z) * 0.25f;
				fragment_output_0.w = (((fragment_unnamed_51.w + fragment_unnamed_59.w) + fragment_unnamed_82.w) + fragment_unnamed_93.w) * 0.25f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[1] = float4(_BlurOffsets[0], _BlurOffsets[1], _BlurOffsets[2], _BlurOffsets[3]);

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
