Shader "Hidden/TonemappingColorGradingHistogram"
{
	Properties
	{
	}
	SubShader
	{
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			Fog
			{
				Mode Off
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 53045

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			#if defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float2 vertex_input_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float2 vertex_input_1 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_76 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].x)) + vertex_uniform_buffer_0[3u].x;
				float vertex_unnamed_77 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].y)) + vertex_uniform_buffer_0[3u].y;
				float vertex_unnamed_78 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].z)) + vertex_uniform_buffer_0[3u].z;
				float vertex_unnamed_79 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].w)) + vertex_uniform_buffer_0[3u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].x)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].y)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].z)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].w)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_0[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_0[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_0[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_1[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_1[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_1[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float2 _Size;
			int _Channel;
			float4 _ColorR;
			float4 _ColorG;
			float4 _ColorB;
			float4 _ColorL;

			static float4 fragment_uniform_buffer_0[7];
			static const float fragment_unnamed_27[16] = { 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f };

			Buffer<uint4> T0;

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
				float fragment_unnamed_35 = fragment_input_1.x * 255.0f;
				float fragment_unnamed_39 = frac(fragment_unnamed_35);
				uint fragment_unnamed_40 = uint(floor(fragment_unnamed_35));
				uint4 fragment_unnamed_50 = asuint(fragment_uniform_buffer_0[2u]);
				uint fragment_unnamed_51 = fragment_unnamed_50.z;
				float fragment_unnamed_84 = asfloat(((mad(float(T0.Load((fragment_unnamed_40 * 4u) + fragment_unnamed_51).x), ((-0.0f) - fragment_unnamed_39) + 1.0f, fragment_unnamed_39 * float(T0.Load((min((fragment_unnamed_40 + 1u), 255u) * 4u) + fragment_unnamed_51).x)) >= float(uint(round(fragment_input_1.y * fragment_uniform_buffer_0[2u].y)))) ? 4294967295u : 0u) & 1065353216u);
				uint4 fragment_unnamed_87 = asuint(fragment_uniform_buffer_0[2u]);
				uint fragment_unnamed_88 = fragment_unnamed_87.z;
				uint fragment_unnamed_97 = (fragment_unnamed_88 * 4u) + 0u;
				uint fragment_unnamed_106 = (fragment_unnamed_88 * 4u) + 1u;
				uint fragment_unnamed_120 = (fragment_unnamed_88 * 4u) + 2u;
				uint fragment_unnamed_135 = (fragment_unnamed_88 * 4u) + 3u;
				fragment_output_0.x = fragment_unnamed_84 * mad(fragment_unnamed_27[fragment_unnamed_135], fragment_uniform_buffer_0[6u].x, mad(fragment_unnamed_27[fragment_unnamed_120], fragment_uniform_buffer_0[5u].x, mad(fragment_unnamed_27[fragment_unnamed_106], fragment_uniform_buffer_0[4u].x, fragment_uniform_buffer_0[3u].x * fragment_unnamed_27[fragment_unnamed_97])));
				fragment_output_0.y = fragment_unnamed_84 * mad(fragment_unnamed_27[fragment_unnamed_135], fragment_uniform_buffer_0[6u].y, mad(fragment_unnamed_27[fragment_unnamed_120], fragment_uniform_buffer_0[5u].y, mad(fragment_unnamed_27[fragment_unnamed_106], fragment_uniform_buffer_0[4u].y, fragment_uniform_buffer_0[3u].y * fragment_unnamed_27[fragment_unnamed_97])));
				fragment_output_0.z = fragment_unnamed_84 * mad(fragment_unnamed_27[fragment_unnamed_135], fragment_uniform_buffer_0[6u].z, mad(fragment_unnamed_27[fragment_unnamed_120], fragment_uniform_buffer_0[5u].z, mad(fragment_unnamed_27[fragment_unnamed_106], fragment_uniform_buffer_0[4u].z, fragment_uniform_buffer_0[3u].z * fragment_unnamed_27[fragment_unnamed_97])));
				fragment_output_0.w = fragment_unnamed_84 * mad(fragment_unnamed_27[fragment_unnamed_135], fragment_uniform_buffer_0[6u].w, mad(fragment_unnamed_27[fragment_unnamed_120], fragment_uniform_buffer_0[5u].w, mad(fragment_unnamed_27[fragment_unnamed_106], fragment_uniform_buffer_0[4u].w, fragment_uniform_buffer_0[3u].w * fragment_unnamed_27[fragment_unnamed_97])));
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_Size[0], _Size[1], fragment_uniform_buffer_0[2][2], fragment_uniform_buffer_0[2][3]);

				fragment_uniform_buffer_0[2] = float4(fragment_uniform_buffer_0[2][0], fragment_uniform_buffer_0[2][1], asfloat(_Channel), fragment_uniform_buffer_0[2][3]);

				fragment_uniform_buffer_0[3] = float4(_ColorR[0], _ColorR[1], _ColorR[2], _ColorR[3]);

				fragment_uniform_buffer_0[4] = float4(_ColorG[0], _ColorG[1], _ColorG[2], _ColorG[3]);

				fragment_uniform_buffer_0[5] = float4(_ColorB[0], _ColorB[1], _ColorB[2], _ColorB[3]);

				fragment_uniform_buffer_0[6] = float4(_ColorL[0], _ColorL[1], _ColorL[2], _ColorL[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}



			#endif
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			#define RIP_HAS_VERT
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float2 vertex_input_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float2 vertex_input_1 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_76 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].x)) + vertex_uniform_buffer_0[3u].x;
				float vertex_unnamed_77 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].y)) + vertex_uniform_buffer_0[3u].y;
				float vertex_unnamed_78 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].z)) + vertex_uniform_buffer_0[3u].z;
				float vertex_unnamed_79 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].w)) + vertex_uniform_buffer_0[3u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].x)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].y)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].z)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].w)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_0[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_0[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_0[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_1[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_1[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_1[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			#define RIP_HAS_FRAG


			float2 _Size;
			int _Channel;
			float4 _ColorR;
			float4 _ColorG;
			float4 _ColorB;
			float4 _ColorL;

			static float4 fragment_uniform_buffer_0[7];
			static const float fragment_unnamed_27[16] = { 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f };

			Buffer<uint4> T0;

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
				float fragment_unnamed_35 = fragment_input_1.x * 255.0f;
				float fragment_unnamed_39 = frac(fragment_unnamed_35);
				uint fragment_unnamed_40 = uint(floor(fragment_unnamed_35));
				uint4 fragment_unnamed_50 = asuint(fragment_uniform_buffer_0[2u]);
				uint fragment_unnamed_51 = fragment_unnamed_50.z;
				float fragment_unnamed_84 = asfloat(((mad(float(T0.Load((fragment_unnamed_40 * 4u) + fragment_unnamed_51).x), ((-0.0f) - fragment_unnamed_39) + 1.0f, fragment_unnamed_39 * float(T0.Load((min((fragment_unnamed_40 + 1u), 255u) * 4u) + fragment_unnamed_51).x)) >= float(uint(round(fragment_input_1.y * fragment_uniform_buffer_0[2u].y)))) ? 4294967295u : 0u) & 1065353216u);
				uint4 fragment_unnamed_87 = asuint(fragment_uniform_buffer_0[2u]);
				uint fragment_unnamed_88 = fragment_unnamed_87.z;
				uint fragment_unnamed_97 = (fragment_unnamed_88 * 4u) + 0u;
				uint fragment_unnamed_106 = (fragment_unnamed_88 * 4u) + 1u;
				uint fragment_unnamed_120 = (fragment_unnamed_88 * 4u) + 2u;
				uint fragment_unnamed_135 = (fragment_unnamed_88 * 4u) + 3u;
				fragment_output_0.x = fragment_unnamed_84 * mad(fragment_unnamed_27[fragment_unnamed_135], fragment_uniform_buffer_0[6u].x, mad(fragment_unnamed_27[fragment_unnamed_120], fragment_uniform_buffer_0[5u].x, mad(fragment_unnamed_27[fragment_unnamed_106], fragment_uniform_buffer_0[4u].x, fragment_uniform_buffer_0[3u].x * fragment_unnamed_27[fragment_unnamed_97])));
				fragment_output_0.y = fragment_unnamed_84 * mad(fragment_unnamed_27[fragment_unnamed_135], fragment_uniform_buffer_0[6u].y, mad(fragment_unnamed_27[fragment_unnamed_120], fragment_uniform_buffer_0[5u].y, mad(fragment_unnamed_27[fragment_unnamed_106], fragment_uniform_buffer_0[4u].y, fragment_uniform_buffer_0[3u].y * fragment_unnamed_27[fragment_unnamed_97])));
				fragment_output_0.z = fragment_unnamed_84 * mad(fragment_unnamed_27[fragment_unnamed_135], fragment_uniform_buffer_0[6u].z, mad(fragment_unnamed_27[fragment_unnamed_120], fragment_uniform_buffer_0[5u].z, mad(fragment_unnamed_27[fragment_unnamed_106], fragment_uniform_buffer_0[4u].z, fragment_uniform_buffer_0[3u].z * fragment_unnamed_27[fragment_unnamed_97])));
				fragment_output_0.w = fragment_unnamed_84 * mad(fragment_unnamed_27[fragment_unnamed_135], fragment_uniform_buffer_0[6u].w, mad(fragment_unnamed_27[fragment_unnamed_120], fragment_uniform_buffer_0[5u].w, mad(fragment_unnamed_27[fragment_unnamed_106], fragment_uniform_buffer_0[4u].w, fragment_uniform_buffer_0[3u].w * fragment_unnamed_27[fragment_unnamed_97])));
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_Size[0], _Size[1], fragment_uniform_buffer_0[2][2], fragment_uniform_buffer_0[2][3]);

				fragment_uniform_buffer_0[2] = float4(fragment_uniform_buffer_0[2][0], fragment_uniform_buffer_0[2][1], asfloat(_Channel), fragment_uniform_buffer_0[2][3]);

				fragment_uniform_buffer_0[3] = float4(_ColorR[0], _ColorR[1], _ColorR[2], _ColorR[3]);

				fragment_uniform_buffer_0[4] = float4(_ColorG[0], _ColorG[1], _ColorG[2], _ColorG[3]);

				fragment_uniform_buffer_0[5] = float4(_ColorB[0], _ColorB[1], _ColorB[2], _ColorB[3]);

				fragment_uniform_buffer_0[6] = float4(_ColorL[0], _ColorL[1], _ColorL[2], _ColorL[3]);

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
			ZTest Always
			ZWrite Off
			Cull Off
			Fog
			{
				Mode Off
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 67825

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			#if defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float2 vertex_input_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float2 vertex_input_1 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_76 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].x)) + vertex_uniform_buffer_0[3u].x;
				float vertex_unnamed_77 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].y)) + vertex_uniform_buffer_0[3u].y;
				float vertex_unnamed_78 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].z)) + vertex_uniform_buffer_0[3u].z;
				float vertex_unnamed_79 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].w)) + vertex_uniform_buffer_0[3u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].x)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].y)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].z)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].w)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_0[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_0[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_0[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_1[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_1[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_1[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float2 _Size;
			float4 _ColorR;
			float4 _ColorG;
			float4 _ColorB;

			static float4 fragment_uniform_buffer_0[6];
			Buffer<uint4> T0;

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
				float fragment_unnamed_28 = fragment_input_1.x * 255.0f;
				float fragment_unnamed_32 = frac(fragment_unnamed_28);
				uint fragment_unnamed_33 = uint(floor(fragment_unnamed_28));
				uint fragment_unnamed_36 = fragment_unnamed_33 * 4u;
				uint3 fragment_unnamed_49 = uint3(T0.Load(fragment_unnamed_36).x, T0.Load(fragment_unnamed_36 + 1u).x, T0.Load(fragment_unnamed_36 + 2u).x);
				uint fragment_unnamed_58 = min((fragment_unnamed_33 + 1u), 255u) * 4u;
				uint3 fragment_unnamed_67 = uint3(T0.Load(fragment_unnamed_58).x, T0.Load(fragment_unnamed_58 + 1u).x, T0.Load(fragment_unnamed_58 + 2u).x);
				float fragment_unnamed_79 = ((-0.0f) - fragment_unnamed_32) + 1.0f;
				float fragment_unnamed_93 = float(uint(round(fragment_input_1.y * fragment_uniform_buffer_0[2u].y)));
				float fragment_unnamed_104 = asfloat(((mad(float(fragment_unnamed_49.x), fragment_unnamed_79, fragment_unnamed_32 * float(fragment_unnamed_67.x)) >= fragment_unnamed_93) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_107 = asfloat(((mad(float(fragment_unnamed_49.z), fragment_unnamed_79, fragment_unnamed_32 * float(fragment_unnamed_67.z)) >= fragment_unnamed_93) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_108 = asfloat(((mad(float(fragment_unnamed_49.y), fragment_unnamed_79, fragment_unnamed_32 * float(fragment_unnamed_67.y)) >= fragment_unnamed_93) ? 4294967295u : 0u) & 1065353216u);
				fragment_output_0.x = clamp(mad(fragment_unnamed_107, fragment_uniform_buffer_0[5u].x, mad(fragment_unnamed_104, fragment_uniform_buffer_0[3u].x, fragment_unnamed_108 * fragment_uniform_buffer_0[4u].x)), 0.0f, 1.0f);
				fragment_output_0.y = clamp(mad(fragment_unnamed_107, fragment_uniform_buffer_0[5u].y, mad(fragment_unnamed_104, fragment_uniform_buffer_0[3u].y, fragment_unnamed_108 * fragment_uniform_buffer_0[4u].y)), 0.0f, 1.0f);
				fragment_output_0.z = clamp(mad(fragment_unnamed_107, fragment_uniform_buffer_0[5u].z, mad(fragment_unnamed_104, fragment_uniform_buffer_0[3u].z, fragment_unnamed_108 * fragment_uniform_buffer_0[4u].z)), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(fragment_unnamed_107, fragment_uniform_buffer_0[5u].w, mad(fragment_unnamed_104, fragment_uniform_buffer_0[3u].w, fragment_unnamed_108 * fragment_uniform_buffer_0[4u].w)), 0.0f, 1.0f);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_Size[0], _Size[1], fragment_uniform_buffer_0[2][2], fragment_uniform_buffer_0[2][3]);

				fragment_uniform_buffer_0[3] = float4(_ColorR[0], _ColorR[1], _ColorR[2], _ColorR[3]);

				fragment_uniform_buffer_0[4] = float4(_ColorG[0], _ColorG[1], _ColorG[2], _ColorG[3]);

				fragment_uniform_buffer_0[5] = float4(_ColorB[0], _ColorB[1], _ColorB[2], _ColorB[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}



			#endif
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			#define RIP_HAS_VERT
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[4];
			static float4 vertex_uniform_buffer_1[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float2 vertex_input_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float2 vertex_input_1 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_76 = mad(vertex_uniform_buffer_0[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].x, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].x)) + vertex_uniform_buffer_0[3u].x;
				float vertex_unnamed_77 = mad(vertex_uniform_buffer_0[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].y, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].y)) + vertex_uniform_buffer_0[3u].y;
				float vertex_unnamed_78 = mad(vertex_uniform_buffer_0[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].z, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].z)) + vertex_uniform_buffer_0[3u].z;
				float vertex_unnamed_79 = mad(vertex_uniform_buffer_0[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_0[0u].w, vertex_input_0.x, vertex_input_0.y * vertex_uniform_buffer_0[1u].w)) + vertex_uniform_buffer_0[3u].w;
				gl_Position.x = mad(vertex_uniform_buffer_1[20u].x, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].x, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].x, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].x)));
				gl_Position.y = mad(vertex_uniform_buffer_1[20u].y, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].y, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].y, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].y)));
				gl_Position.z = mad(vertex_uniform_buffer_1[20u].z, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].z, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].z, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].z)));
				gl_Position.w = mad(vertex_uniform_buffer_1[20u].w, vertex_unnamed_79, mad(vertex_uniform_buffer_1[19u].w, vertex_unnamed_78, mad(vertex_uniform_buffer_1[17u].w, vertex_unnamed_76, vertex_unnamed_77 * vertex_uniform_buffer_1[18u].w)));
				vertex_output_1.x = vertex_input_1.x;
				vertex_output_1.y = vertex_input_1.y;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_0[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_0[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_0[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_1[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_1[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_1[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			#define RIP_HAS_FRAG


			float2 _Size;
			float4 _ColorR;
			float4 _ColorG;
			float4 _ColorB;

			static float4 fragment_uniform_buffer_0[6];
			Buffer<uint4> T0;

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
				float fragment_unnamed_28 = fragment_input_1.x * 255.0f;
				float fragment_unnamed_32 = frac(fragment_unnamed_28);
				uint fragment_unnamed_33 = uint(floor(fragment_unnamed_28));
				uint fragment_unnamed_36 = fragment_unnamed_33 * 4u;
				uint3 fragment_unnamed_49 = uint3(T0.Load(fragment_unnamed_36).x, T0.Load(fragment_unnamed_36 + 1u).x, T0.Load(fragment_unnamed_36 + 2u).x);
				uint fragment_unnamed_58 = min((fragment_unnamed_33 + 1u), 255u) * 4u;
				uint3 fragment_unnamed_67 = uint3(T0.Load(fragment_unnamed_58).x, T0.Load(fragment_unnamed_58 + 1u).x, T0.Load(fragment_unnamed_58 + 2u).x);
				float fragment_unnamed_79 = ((-0.0f) - fragment_unnamed_32) + 1.0f;
				float fragment_unnamed_93 = float(uint(round(fragment_input_1.y * fragment_uniform_buffer_0[2u].y)));
				float fragment_unnamed_104 = asfloat(((mad(float(fragment_unnamed_49.x), fragment_unnamed_79, fragment_unnamed_32 * float(fragment_unnamed_67.x)) >= fragment_unnamed_93) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_107 = asfloat(((mad(float(fragment_unnamed_49.z), fragment_unnamed_79, fragment_unnamed_32 * float(fragment_unnamed_67.z)) >= fragment_unnamed_93) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_108 = asfloat(((mad(float(fragment_unnamed_49.y), fragment_unnamed_79, fragment_unnamed_32 * float(fragment_unnamed_67.y)) >= fragment_unnamed_93) ? 4294967295u : 0u) & 1065353216u);
				fragment_output_0.x = clamp(mad(fragment_unnamed_107, fragment_uniform_buffer_0[5u].x, mad(fragment_unnamed_104, fragment_uniform_buffer_0[3u].x, fragment_unnamed_108 * fragment_uniform_buffer_0[4u].x)), 0.0f, 1.0f);
				fragment_output_0.y = clamp(mad(fragment_unnamed_107, fragment_uniform_buffer_0[5u].y, mad(fragment_unnamed_104, fragment_uniform_buffer_0[3u].y, fragment_unnamed_108 * fragment_uniform_buffer_0[4u].y)), 0.0f, 1.0f);
				fragment_output_0.z = clamp(mad(fragment_unnamed_107, fragment_uniform_buffer_0[5u].z, mad(fragment_unnamed_104, fragment_uniform_buffer_0[3u].z, fragment_unnamed_108 * fragment_uniform_buffer_0[4u].z)), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(fragment_unnamed_107, fragment_uniform_buffer_0[5u].w, mad(fragment_unnamed_104, fragment_uniform_buffer_0[3u].w, fragment_unnamed_108 * fragment_uniform_buffer_0[4u].w)), 0.0f, 1.0f);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_Size[0], _Size[1], fragment_uniform_buffer_0[2][2], fragment_uniform_buffer_0[2][3]);

				fragment_uniform_buffer_0[3] = float4(_ColorR[0], _ColorR[1], _ColorR[2], _ColorR[3]);

				fragment_uniform_buffer_0[4] = float4(_ColorG[0], _ColorG[1], _ColorG[2], _ColorG[3]);

				fragment_uniform_buffer_0[5] = float4(_ColorB[0], _ColorB[1], _ColorB[2], _ColorB[3]);

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
