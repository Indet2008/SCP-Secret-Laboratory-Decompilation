Shader "Hidden/Renderers/Darken"
{
	Properties
	{
	}
	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" }
		Pass
		{
			Name "Custom Pass 0"
			Tags { "RenderPipeline" = "HDRenderPipeline" }
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
			GpuProgramID 16748

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
			#endif
			#if defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float _CustomPassInjectionPoint;
			float _DarknessIntensity;

			static float4 fragment_uniform_buffer_0[1];
			Texture2DArray<float4> _ColorPyramidTexture;
			Texture2DArray<float4> _AfterPostProcessColorBuffer;

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
				uint fragment_unnamed_29 = uint(gl_FragCoord.x);
				uint fragment_unnamed_30 = uint(gl_FragCoord.y);
				float fragment_unnamed_55;
				float fragment_unnamed_56;
				float fragment_unnamed_57;
				switch (uint(int(fragment_uniform_buffer_0[0u].x)))
				{
					case 0u:
					{
						fragment_unnamed_55 = asfloat(0u);
						fragment_unnamed_56 = asfloat(0u);
						fragment_unnamed_57 = asfloat(0u);
						break;
					}
					case 1u:
					case 4u:
					{
						float4 fragment_unnamed_45 = _ColorPyramidTexture.Load(int4(uint3(fragment_unnamed_29, fragment_unnamed_30, 0u), 0u));
						fragment_unnamed_55 = fragment_unnamed_45.x;
						fragment_unnamed_56 = fragment_unnamed_45.y;
						fragment_unnamed_57 = fragment_unnamed_45.z;
						break;
					}
					case 3u:
					{
						float4 fragment_unnamed_50 = _AfterPostProcessColorBuffer.Load(int4(uint3(fragment_unnamed_29, fragment_unnamed_30, 0u), 0u));
						fragment_unnamed_55 = fragment_unnamed_50.x;
						fragment_unnamed_56 = fragment_unnamed_50.y;
						fragment_unnamed_57 = fragment_unnamed_50.z;
						break;
					}
					default:
					{
						float4 fragment_unnamed_36 = _ColorPyramidTexture.Load(int4(uint3(fragment_unnamed_29, fragment_unnamed_30, 0u), 0u));
						fragment_unnamed_55 = fragment_unnamed_36.x;
						fragment_unnamed_56 = fragment_unnamed_36.y;
						fragment_unnamed_57 = fragment_unnamed_36.z;
						break;
					}
				}
				fragment_output_0.x = fragment_unnamed_55;
				fragment_output_0.y = fragment_unnamed_56;
				fragment_output_0.z = fragment_unnamed_57;
				fragment_output_0.w = fragment_uniform_buffer_0[0u].z;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_CustomPassInjectionPoint, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], fragment_uniform_buffer_0[0][1], _DarknessIntensity, fragment_uniform_buffer_0[0][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
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
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			#define RIP_HAS_FRAG


			float _CustomPassInjectionPoint;
			float _DarknessIntensity;

			static float4 fragment_uniform_buffer_0[1];
			Texture2DArray<float4> _ColorPyramidTexture;
			Texture2DArray<float4> _AfterPostProcessColorBuffer;

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
				uint fragment_unnamed_29 = uint(gl_FragCoord.x);
				uint fragment_unnamed_30 = uint(gl_FragCoord.y);
				float fragment_unnamed_55;
				float fragment_unnamed_56;
				float fragment_unnamed_57;
				switch (uint(int(fragment_uniform_buffer_0[0u].x)))
				{
					case 0u:
					{
						fragment_unnamed_55 = asfloat(0u);
						fragment_unnamed_56 = asfloat(0u);
						fragment_unnamed_57 = asfloat(0u);
						break;
					}
					case 1u:
					case 4u:
					{
						float4 fragment_unnamed_45 = _ColorPyramidTexture.Load(int4(uint3(fragment_unnamed_29, fragment_unnamed_30, 0u), 0u));
						fragment_unnamed_55 = fragment_unnamed_45.x;
						fragment_unnamed_56 = fragment_unnamed_45.y;
						fragment_unnamed_57 = fragment_unnamed_45.z;
						break;
					}
					case 3u:
					{
						float4 fragment_unnamed_50 = _AfterPostProcessColorBuffer.Load(int4(uint3(fragment_unnamed_29, fragment_unnamed_30, 0u), 0u));
						fragment_unnamed_55 = fragment_unnamed_50.x;
						fragment_unnamed_56 = fragment_unnamed_50.y;
						fragment_unnamed_57 = fragment_unnamed_50.z;
						break;
					}
					default:
					{
						float4 fragment_unnamed_36 = _ColorPyramidTexture.Load(int4(uint3(fragment_unnamed_29, fragment_unnamed_30, 0u), 0u));
						fragment_unnamed_55 = fragment_unnamed_36.x;
						fragment_unnamed_56 = fragment_unnamed_36.y;
						fragment_unnamed_57 = fragment_unnamed_36.z;
						break;
					}
				}
				fragment_output_0.x = fragment_unnamed_55;
				fragment_output_0.y = fragment_unnamed_56;
				fragment_output_0.z = fragment_unnamed_57;
				fragment_output_0.w = fragment_uniform_buffer_0[0u].z;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_CustomPassInjectionPoint, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], fragment_uniform_buffer_0[0][1], _DarknessIntensity, fragment_uniform_buffer_0[0][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
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
