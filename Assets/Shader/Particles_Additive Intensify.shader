Shader "Particles/Additive Intensify"
{
	Properties
	{
		_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_InvFade ("Soft Particles Factor", Range(0.01, 90)) = 1
		_Glow ("Intensity", Range(0, 300)) = 1
	}
	SubShader
	{
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Overlay" }
		Pass
		{
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Overlay" }
			Blend SrcAlpha One
			ColorMask RGB
			ZWrite Off
			Cull Off
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 62711

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma multi_compile _ FOG_LINEAR
			#pragma multi_compile _ SOFTPARTICLES_ON


			#if !defined(FOG_LINEAR) && !defined(SOFTPARTICLES_ON)

			float4 _TintColor;
			float _Glow;
			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[5];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_46 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_47 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_48 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_49 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				precise float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_46)) + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_47)) + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_85 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_48)) + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_49)) + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_94 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_95 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_96 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_97 = vertex_unnamed_84 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_83, vertex_unnamed_94)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_83, vertex_unnamed_95)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_83, vertex_unnamed_96)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_86, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_85, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_83, vertex_unnamed_97)));
				precise float vertex_unnamed_150 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_151 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_152 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_153 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				precise float vertex_unnamed_157 = vertex_unnamed_150 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_158 = vertex_unnamed_151 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_159 = vertex_unnamed_152 * vertex_uniform_buffer_0[3u].x;
				vertex_output_1.x = vertex_unnamed_157;
				vertex_output_1.y = vertex_unnamed_158;
				vertex_output_1.z = vertex_unnamed_159;
				vertex_output_1.w = vertex_unnamed_153;
				vertex_output_2.x = mad(vertex_input_2.x, vertex_uniform_buffer_0[4u].x, vertex_uniform_buffer_0[4u].z);
				vertex_output_2.y = mad(vertex_input_2.y, vertex_uniform_buffer_0[4u].y, vertex_uniform_buffer_0[4u].w);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_TintColor[0], _TintColor[1], _TintColor[2], _TintColor[3]);

				vertex_uniform_buffer_0[3] = float4(_Glow, vertex_uniform_buffer_0[3][1], vertex_uniform_buffer_0[3][2], vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[4] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}


			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_45 = fragment_input_1.x + fragment_input_1.x;
				precise float fragment_unnamed_46 = fragment_input_1.y + fragment_input_1.y;
				precise float fragment_unnamed_47 = fragment_input_1.z + fragment_input_1.z;
				precise float fragment_unnamed_48 = fragment_input_1.w + fragment_input_1.w;
				float4 fragment_unnamed_56 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				precise float fragment_unnamed_62 = fragment_unnamed_45 * fragment_unnamed_56.x;
				precise float fragment_unnamed_63 = fragment_unnamed_46 * fragment_unnamed_56.y;
				precise float fragment_unnamed_64 = fragment_unnamed_47 * fragment_unnamed_56.z;
				precise float fragment_unnamed_65 = fragment_unnamed_48 * fragment_unnamed_56.w;
				fragment_output_0.x = fragment_unnamed_62;
				fragment_output_0.y = fragment_unnamed_63;
				fragment_output_0.z = fragment_unnamed_64;
				fragment_output_0.w = fragment_unnamed_65;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // !defined(FOG_LINEAR) && !defined(SOFTPARTICLES_ON)


			#if defined(FOG_LINEAR) && !defined(SOFTPARTICLES_ON)

			float4 _TintColor;
			float _Glow;
			float4 _MainTex_ST;
			float4 _ProjectionParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 unity_FogParams;

			static float4 vertex_uniform_buffer_0[5];
			static float4 vertex_uniform_buffer_1[6];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 vertex_uniform_buffer_4[2];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float vertex_output_fog;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float vertex_output_fog : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_60 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_61 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_58)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_95 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_59)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_96 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_60)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_97 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_61)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_105 = vertex_unnamed_95 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_106 = vertex_unnamed_95 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_107 = vertex_unnamed_95 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_108 = vertex_unnamed_95 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_140 = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_97, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_96, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_94, vertex_unnamed_107)));
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_97, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_96, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_94, vertex_unnamed_105)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_97, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_96, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_94, vertex_unnamed_106)));
				gl_Position.z = vertex_unnamed_140;
				gl_Position.w = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_97, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_96, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_94, vertex_unnamed_108)));
				precise float vertex_unnamed_149 = vertex_unnamed_140 / vertex_uniform_buffer_1[5u].y;
				precise float vertex_unnamed_150 = (-0.0f) - vertex_unnamed_149;
				precise float vertex_unnamed_152 = vertex_unnamed_150 + 1.0f;
				precise float vertex_unnamed_157 = vertex_unnamed_152 * vertex_uniform_buffer_1[5u].z;
				vertex_output_fog = mad(max(vertex_unnamed_157, 0.0f), vertex_uniform_buffer_4[1u].z, vertex_uniform_buffer_4[1u].w);
				precise float vertex_unnamed_181 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_182 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_183 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_184 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				precise float vertex_unnamed_188 = vertex_unnamed_181 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_189 = vertex_unnamed_182 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_190 = vertex_unnamed_183 * vertex_uniform_buffer_0[3u].x;
				vertex_output_1.x = vertex_unnamed_188;
				vertex_output_1.y = vertex_unnamed_189;
				vertex_output_1.z = vertex_unnamed_190;
				vertex_output_1.w = vertex_unnamed_184;
				vertex_output_2.x = mad(vertex_input_2.x, vertex_uniform_buffer_0[4u].x, vertex_uniform_buffer_0[4u].z);
				vertex_output_2.y = mad(vertex_input_2.y, vertex_uniform_buffer_0[4u].y, vertex_uniform_buffer_0[4u].w);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_TintColor[0], _TintColor[1], _TintColor[2], _TintColor[3]);

				vertex_uniform_buffer_0[3] = float4(_Glow, vertex_uniform_buffer_0[3][1], vertex_uniform_buffer_0[3][2], vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[4] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[5] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_3[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_3[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_3[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_uniform_buffer_4[1] = float4(unity_FogParams[0], unity_FogParams[1], unity_FogParams[2], unity_FogParams[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_fog = vertex_output_fog;
				return stage_output;
			}


			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float fragment_input_fog;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float fragment_input_fog : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_46 = fragment_input_1.x + fragment_input_1.x;
				precise float fragment_unnamed_47 = fragment_input_1.y + fragment_input_1.y;
				precise float fragment_unnamed_48 = fragment_input_1.z + fragment_input_1.z;
				precise float fragment_unnamed_49 = fragment_input_1.w + fragment_input_1.w;
				float4 fragment_unnamed_57 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				precise float fragment_unnamed_63 = fragment_unnamed_46 * fragment_unnamed_57.x;
				precise float fragment_unnamed_64 = fragment_unnamed_47 * fragment_unnamed_57.y;
				precise float fragment_unnamed_65 = fragment_unnamed_48 * fragment_unnamed_57.z;
				precise float fragment_unnamed_66 = fragment_unnamed_49 * fragment_unnamed_57.w;
				float fragment_unnamed_70 = clamp(fragment_input_fog, 0.0f, 1.0f);
				precise float fragment_unnamed_71 = fragment_unnamed_63 * fragment_unnamed_70;
				precise float fragment_unnamed_72 = fragment_unnamed_64 * fragment_unnamed_70;
				precise float fragment_unnamed_73 = fragment_unnamed_65 * fragment_unnamed_70;
				fragment_output_0.x = fragment_unnamed_71;
				fragment_output_0.y = fragment_unnamed_72;
				fragment_output_0.z = fragment_unnamed_73;
				fragment_output_0.w = fragment_unnamed_66;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_fog = stage_input.fragment_input_fog;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FOG_LINEAR) && !defined(SOFTPARTICLES_ON)


			#if defined(SOFTPARTICLES_ON) && !defined(FOG_LINEAR)

			float4 _TintColor;
			float _Glow;
			float4 _MainTex_ST;
			float4 _ProjectionParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixV;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[5];
			static float4 vertex_uniform_buffer_1[6];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_52 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_53 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_54 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_89 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_52)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_90 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_53)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_54)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_55)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_100 = vertex_unnamed_90 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_101 = vertex_unnamed_90 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_102 = vertex_unnamed_90 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_103 = vertex_unnamed_90 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_133 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_89, vertex_unnamed_100)));
				float vertex_unnamed_134 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_89, vertex_unnamed_101)));
				float vertex_unnamed_136 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_89, vertex_unnamed_103)));
				gl_Position.x = vertex_unnamed_133;
				gl_Position.y = vertex_unnamed_134;
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_89, vertex_unnamed_102)));
				gl_Position.w = vertex_unnamed_136;
				precise float vertex_unnamed_156 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_157 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_158 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_159 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				precise float vertex_unnamed_163 = vertex_unnamed_156 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_164 = vertex_unnamed_157 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_165 = vertex_unnamed_158 * vertex_uniform_buffer_0[3u].x;
				vertex_output_1.x = vertex_unnamed_163;
				vertex_output_1.y = vertex_unnamed_164;
				vertex_output_1.z = vertex_unnamed_165;
				vertex_output_1.w = vertex_unnamed_159;
				vertex_output_2.x = mad(vertex_input_2.x, vertex_uniform_buffer_0[4u].x, vertex_uniform_buffer_0[4u].z);
				vertex_output_2.y = mad(vertex_input_2.y, vertex_uniform_buffer_0[4u].y, vertex_uniform_buffer_0[4u].w);
				precise float vertex_unnamed_190 = vertex_unnamed_90 * vertex_uniform_buffer_3[10u].z;
				precise float vertex_unnamed_206 = (-0.0f) - mad(vertex_uniform_buffer_3[12u].z, vertex_unnamed_92, mad(vertex_uniform_buffer_3[11u].z, vertex_unnamed_91, mad(vertex_uniform_buffer_3[9u].z, vertex_unnamed_89, vertex_unnamed_190)));
				vertex_output_3.z = vertex_unnamed_206;
				precise float vertex_unnamed_212 = vertex_unnamed_134 * vertex_uniform_buffer_1[5u].x;
				precise float vertex_unnamed_213 = vertex_unnamed_212 * 0.5f;
				precise float vertex_unnamed_215 = vertex_unnamed_133 * 0.5f;
				precise float vertex_unnamed_216 = vertex_unnamed_136 * 0.5f;
				vertex_output_3.w = vertex_unnamed_136;
				precise float vertex_unnamed_218 = vertex_unnamed_216 + vertex_unnamed_215;
				precise float vertex_unnamed_219 = vertex_unnamed_216 + vertex_unnamed_213;
				vertex_output_3.x = vertex_unnamed_218;
				vertex_output_3.y = vertex_unnamed_219;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_TintColor[0], _TintColor[1], _TintColor[2], _TintColor[3]);

				vertex_uniform_buffer_0[3] = float4(_Glow, vertex_uniform_buffer_0[3][1], vertex_uniform_buffer_0[3][2], vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[4] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[5] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[9] = float4(unity_MatrixV[0][0], unity_MatrixV[1][0], unity_MatrixV[2][0], unity_MatrixV[3][0]);
				vertex_uniform_buffer_3[10] = float4(unity_MatrixV[0][1], unity_MatrixV[1][1], unity_MatrixV[2][1], unity_MatrixV[3][1]);
				vertex_uniform_buffer_3[11] = float4(unity_MatrixV[0][2], unity_MatrixV[1][2], unity_MatrixV[2][2], unity_MatrixV[3][2]);
				vertex_uniform_buffer_3[12] = float4(unity_MatrixV[0][3], unity_MatrixV[1][3], unity_MatrixV[2][3], unity_MatrixV[3][3]);

				vertex_uniform_buffer_3[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_3[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_3[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_3[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}


			float _InvFade;
			float4 _ZBufferParams;

			static float4 fragment_uniform_buffer_0[6];
			static float4 fragment_uniform_buffer_1[8];
			Texture2D<float4> _CameraDepthTexture;
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_CameraDepthTexture;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_49 = fragment_input_3.x / fragment_input_3.w;
				precise float fragment_unnamed_50 = fragment_input_3.y / fragment_input_3.w;
				precise float fragment_unnamed_67 = 1.0f / mad(fragment_uniform_buffer_1[7u].z, _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(fragment_unnamed_49, fragment_unnamed_50)).x, fragment_uniform_buffer_1[7u].w);
				precise float fragment_unnamed_72 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_74 = fragment_unnamed_67 + fragment_unnamed_72;
				precise float fragment_unnamed_79 = fragment_unnamed_74 * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_83 = clamp(fragment_unnamed_79, 0.0f, 1.0f) * fragment_input_1.w;
				precise float fragment_unnamed_90 = fragment_input_1.x + fragment_input_1.x;
				precise float fragment_unnamed_91 = fragment_input_1.y + fragment_input_1.y;
				precise float fragment_unnamed_92 = fragment_input_1.z + fragment_input_1.z;
				precise float fragment_unnamed_93 = fragment_unnamed_83 + fragment_unnamed_83;
				float4 fragment_unnamed_99 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				precise float fragment_unnamed_105 = fragment_unnamed_90 * fragment_unnamed_99.x;
				precise float fragment_unnamed_106 = fragment_unnamed_91 * fragment_unnamed_99.y;
				precise float fragment_unnamed_107 = fragment_unnamed_92 * fragment_unnamed_99.z;
				precise float fragment_unnamed_108 = fragment_unnamed_93 * fragment_unnamed_99.w;
				fragment_output_0.x = fragment_unnamed_105;
				fragment_output_0.y = fragment_unnamed_106;
				fragment_output_0.z = fragment_unnamed_107;
				fragment_output_0.w = fragment_unnamed_108;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[5] = float4(_InvFade, fragment_uniform_buffer_0[5][1], fragment_uniform_buffer_0[5][2], fragment_uniform_buffer_0[5][3]);

				fragment_uniform_buffer_1[7] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(SOFTPARTICLES_ON) && !defined(FOG_LINEAR)


			#if defined(FOG_LINEAR) && defined(SOFTPARTICLES_ON)

			float4 _TintColor;
			float _Glow;
			float4 _MainTex_ST;
			float4 _ProjectionParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixV;
			float4x4 unity_MatrixVP;
			float4 unity_FogParams;

			static float4 vertex_uniform_buffer_0[5];
			static float4 vertex_uniform_buffer_1[6];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 vertex_uniform_buffer_4[2];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float vertex_output_fog;
			static float4 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : COLOR; // COLOR
				float2 vertex_input_2 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float vertex_output_fog : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_60 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_61 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_62 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_95 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_59)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_96 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_60)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_97 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_61)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_98 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_62)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_106 = vertex_unnamed_96 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_107 = vertex_unnamed_96 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_108 = vertex_unnamed_96 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_109 = vertex_unnamed_96 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_139 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_98, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_97, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_95, vertex_unnamed_106)));
				float vertex_unnamed_140 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_98, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_97, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_95, vertex_unnamed_107)));
				float vertex_unnamed_141 = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_98, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_97, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_95, vertex_unnamed_108)));
				float vertex_unnamed_142 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_98, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_97, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_95, vertex_unnamed_109)));
				gl_Position.x = vertex_unnamed_139;
				gl_Position.y = vertex_unnamed_140;
				gl_Position.z = vertex_unnamed_141;
				gl_Position.w = vertex_unnamed_142;
				precise float vertex_unnamed_161 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_162 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_163 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_164 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				precise float vertex_unnamed_168 = vertex_unnamed_161 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_169 = vertex_unnamed_162 * vertex_uniform_buffer_0[3u].x;
				precise float vertex_unnamed_170 = vertex_unnamed_163 * vertex_uniform_buffer_0[3u].x;
				vertex_output_1.x = vertex_unnamed_168;
				vertex_output_1.y = vertex_unnamed_169;
				vertex_output_1.z = vertex_unnamed_170;
				vertex_output_1.w = vertex_unnamed_164;
				vertex_output_2.x = mad(vertex_input_2.x, vertex_uniform_buffer_0[4u].x, vertex_uniform_buffer_0[4u].z);
				vertex_output_2.y = mad(vertex_input_2.y, vertex_uniform_buffer_0[4u].y, vertex_uniform_buffer_0[4u].w);
				precise float vertex_unnamed_194 = vertex_unnamed_141 / vertex_uniform_buffer_1[5u].y;
				precise float vertex_unnamed_195 = (-0.0f) - vertex_unnamed_194;
				precise float vertex_unnamed_197 = vertex_unnamed_195 + 1.0f;
				precise float vertex_unnamed_202 = vertex_unnamed_197 * vertex_uniform_buffer_1[5u].z;
				vertex_output_fog = mad(max(vertex_unnamed_202, 0.0f), vertex_uniform_buffer_4[1u].z, vertex_uniform_buffer_4[1u].w);
				precise float vertex_unnamed_216 = vertex_unnamed_96 * vertex_uniform_buffer_3[10u].z;
				precise float vertex_unnamed_232 = (-0.0f) - mad(vertex_uniform_buffer_3[12u].z, vertex_unnamed_98, mad(vertex_uniform_buffer_3[11u].z, vertex_unnamed_97, mad(vertex_uniform_buffer_3[9u].z, vertex_unnamed_95, vertex_unnamed_216)));
				vertex_output_3.z = vertex_unnamed_232;
				precise float vertex_unnamed_237 = vertex_unnamed_140 * vertex_uniform_buffer_1[5u].x;
				precise float vertex_unnamed_238 = vertex_unnamed_237 * 0.5f;
				precise float vertex_unnamed_240 = vertex_unnamed_139 * 0.5f;
				precise float vertex_unnamed_241 = vertex_unnamed_142 * 0.5f;
				vertex_output_3.w = vertex_unnamed_142;
				precise float vertex_unnamed_243 = vertex_unnamed_241 + vertex_unnamed_240;
				precise float vertex_unnamed_244 = vertex_unnamed_241 + vertex_unnamed_238;
				vertex_output_3.x = vertex_unnamed_243;
				vertex_output_3.y = vertex_unnamed_244;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_TintColor[0], _TintColor[1], _TintColor[2], _TintColor[3]);

				vertex_uniform_buffer_0[3] = float4(_Glow, vertex_uniform_buffer_0[3][1], vertex_uniform_buffer_0[3][2], vertex_uniform_buffer_0[3][3]);

				vertex_uniform_buffer_0[4] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[5] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[9] = float4(unity_MatrixV[0][0], unity_MatrixV[1][0], unity_MatrixV[2][0], unity_MatrixV[3][0]);
				vertex_uniform_buffer_3[10] = float4(unity_MatrixV[0][1], unity_MatrixV[1][1], unity_MatrixV[2][1], unity_MatrixV[3][1]);
				vertex_uniform_buffer_3[11] = float4(unity_MatrixV[0][2], unity_MatrixV[1][2], unity_MatrixV[2][2], unity_MatrixV[3][2]);
				vertex_uniform_buffer_3[12] = float4(unity_MatrixV[0][3], unity_MatrixV[1][3], unity_MatrixV[2][3], unity_MatrixV[3][3]);

				vertex_uniform_buffer_3[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_3[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_3[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_3[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_uniform_buffer_4[1] = float4(unity_FogParams[0], unity_FogParams[1], unity_FogParams[2], unity_FogParams[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_fog = vertex_output_fog;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}


			float _InvFade;
			float4 _ZBufferParams;

			static float4 fragment_uniform_buffer_0[6];
			static float4 fragment_uniform_buffer_1[8];
			Texture2D<float4> _CameraDepthTexture;
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_CameraDepthTexture;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float fragment_input_fog;
			static float4 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float fragment_input_fog : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_50 = fragment_input_3.x / fragment_input_3.w;
				precise float fragment_unnamed_51 = fragment_input_3.y / fragment_input_3.w;
				precise float fragment_unnamed_68 = 1.0f / mad(fragment_uniform_buffer_1[7u].z, _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(fragment_unnamed_50, fragment_unnamed_51)).x, fragment_uniform_buffer_1[7u].w);
				precise float fragment_unnamed_73 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_75 = fragment_unnamed_68 + fragment_unnamed_73;
				precise float fragment_unnamed_80 = fragment_unnamed_75 * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_84 = clamp(fragment_unnamed_80, 0.0f, 1.0f) * fragment_input_1.w;
				precise float fragment_unnamed_91 = fragment_input_1.x + fragment_input_1.x;
				precise float fragment_unnamed_92 = fragment_input_1.y + fragment_input_1.y;
				precise float fragment_unnamed_93 = fragment_input_1.z + fragment_input_1.z;
				precise float fragment_unnamed_94 = fragment_unnamed_84 + fragment_unnamed_84;
				float4 fragment_unnamed_100 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				precise float fragment_unnamed_106 = fragment_unnamed_91 * fragment_unnamed_100.x;
				precise float fragment_unnamed_107 = fragment_unnamed_92 * fragment_unnamed_100.y;
				precise float fragment_unnamed_108 = fragment_unnamed_93 * fragment_unnamed_100.z;
				precise float fragment_unnamed_109 = fragment_unnamed_94 * fragment_unnamed_100.w;
				float fragment_unnamed_111 = clamp(fragment_input_fog, 0.0f, 1.0f);
				precise float fragment_unnamed_112 = fragment_unnamed_106 * fragment_unnamed_111;
				precise float fragment_unnamed_113 = fragment_unnamed_107 * fragment_unnamed_111;
				precise float fragment_unnamed_114 = fragment_unnamed_108 * fragment_unnamed_111;
				fragment_output_0.x = fragment_unnamed_112;
				fragment_output_0.y = fragment_unnamed_113;
				fragment_output_0.z = fragment_unnamed_114;
				fragment_output_0.w = fragment_unnamed_109;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[5] = float4(_InvFade, fragment_uniform_buffer_0[5][1], fragment_uniform_buffer_0[5][2], fragment_uniform_buffer_0[5][3]);

				fragment_uniform_buffer_1[7] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_fog = stage_input.fragment_input_fog;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FOG_LINEAR) && defined(SOFTPARTICLES_ON)


			ENDHLSL
		}
	}
}
