Shader "Hidden/Shader/Radial Blur"
{
	Properties
	{
		_MainTex ("Main Texture", 2DArray) = "grey" {}
	}
	SubShader
	{
		Pass
		{
			Name "Radial Blur"
			ZTest Always
			ZWrite Off
			Cull Off
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 30751

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


			float _Amount;
			float _Iterations;
			float4 _RTHandleScale;

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[53];
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
				float fragment_unnamed_42 = ((-0.0f) - fragment_input_1.x) + 0.5f;
				float fragment_unnamed_44 = ((-0.0f) - fragment_input_1.y) + 0.5f;
				float fragment_unnamed_91;
				float fragment_unnamed_92;
				float fragment_unnamed_93;
				float fragment_unnamed_94;
				float fragment_unnamed_95;
				float fragment_unnamed_96;
				uint fragment_unnamed_97;
				if (0.0f < fragment_uniform_buffer_0[0u].y)
				{
					float4 fragment_unnamed_66 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_input_1.x * fragment_uniform_buffer_1[52u].x, fragment_input_1.y * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_91 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_input_1.x);
					fragment_unnamed_92 = fragment_unnamed_66.x;
					fragment_unnamed_93 = fragment_unnamed_66.y;
					fragment_unnamed_94 = fragment_unnamed_66.z;
					fragment_unnamed_95 = fragment_unnamed_66.w;
					fragment_unnamed_96 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_input_1.y);
					fragment_unnamed_97 = 1u;
				}
				else
				{
					fragment_unnamed_91 = fragment_input_1.x;
					fragment_unnamed_92 = asfloat(0u);
					fragment_unnamed_93 = asfloat(0u);
					fragment_unnamed_94 = asfloat(0u);
					fragment_unnamed_95 = asfloat(0u);
					fragment_unnamed_96 = fragment_input_1.y;
					fragment_unnamed_97 = 0u;
				}
				bool fragment_unnamed_102 = float(int(fragment_unnamed_97)) < fragment_uniform_buffer_0[0u].y;
				float fragment_unnamed_128;
				float fragment_unnamed_129;
				float fragment_unnamed_130;
				float fragment_unnamed_131;
				float fragment_unnamed_132;
				float fragment_unnamed_133;
				uint fragment_unnamed_134;
				if (fragment_unnamed_102)
				{
					float4 fragment_unnamed_113 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_91 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_96 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_128 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_91);
					fragment_unnamed_129 = fragment_unnamed_92 + fragment_unnamed_113.x;
					fragment_unnamed_130 = fragment_unnamed_93 + fragment_unnamed_113.y;
					fragment_unnamed_131 = fragment_unnamed_94 + fragment_unnamed_113.z;
					fragment_unnamed_132 = fragment_unnamed_95 + fragment_unnamed_113.w;
					fragment_unnamed_133 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_96);
					fragment_unnamed_134 = 2u;
				}
				else
				{
					fragment_unnamed_128 = fragment_unnamed_91;
					fragment_unnamed_129 = fragment_unnamed_92;
					fragment_unnamed_130 = fragment_unnamed_93;
					fragment_unnamed_131 = fragment_unnamed_94;
					fragment_unnamed_132 = fragment_unnamed_95;
					fragment_unnamed_133 = fragment_unnamed_96;
					fragment_unnamed_134 = fragment_unnamed_97;
				}
				uint fragment_unnamed_142 = ((float(int(fragment_unnamed_134)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & (fragment_unnamed_102 ? 4294967295u : 0u);
				float fragment_unnamed_167;
				float fragment_unnamed_168;
				float fragment_unnamed_169;
				float fragment_unnamed_170;
				float fragment_unnamed_171;
				float fragment_unnamed_172;
				uint fragment_unnamed_173;
				if (fragment_unnamed_142 != 0u)
				{
					float4 fragment_unnamed_152 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_128 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_133 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_167 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_128);
					fragment_unnamed_168 = fragment_unnamed_129 + fragment_unnamed_152.x;
					fragment_unnamed_169 = fragment_unnamed_130 + fragment_unnamed_152.y;
					fragment_unnamed_170 = fragment_unnamed_131 + fragment_unnamed_152.z;
					fragment_unnamed_171 = fragment_unnamed_132 + fragment_unnamed_152.w;
					fragment_unnamed_172 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_133);
					fragment_unnamed_173 = 3u;
				}
				else
				{
					fragment_unnamed_167 = fragment_unnamed_128;
					fragment_unnamed_168 = fragment_unnamed_129;
					fragment_unnamed_169 = fragment_unnamed_130;
					fragment_unnamed_170 = fragment_unnamed_131;
					fragment_unnamed_171 = fragment_unnamed_132;
					fragment_unnamed_172 = fragment_unnamed_133;
					fragment_unnamed_173 = fragment_unnamed_134;
				}
				uint fragment_unnamed_181 = ((float(int(fragment_unnamed_173)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_142;
				float fragment_unnamed_206;
				float fragment_unnamed_207;
				float fragment_unnamed_208;
				float fragment_unnamed_209;
				float fragment_unnamed_210;
				float fragment_unnamed_211;
				uint fragment_unnamed_212;
				if (fragment_unnamed_181 != 0u)
				{
					float4 fragment_unnamed_191 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_167 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_172 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_206 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_167);
					fragment_unnamed_207 = fragment_unnamed_168 + fragment_unnamed_191.x;
					fragment_unnamed_208 = fragment_unnamed_169 + fragment_unnamed_191.y;
					fragment_unnamed_209 = fragment_unnamed_170 + fragment_unnamed_191.z;
					fragment_unnamed_210 = fragment_unnamed_171 + fragment_unnamed_191.w;
					fragment_unnamed_211 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_172);
					fragment_unnamed_212 = 4u;
				}
				else
				{
					fragment_unnamed_206 = fragment_unnamed_167;
					fragment_unnamed_207 = fragment_unnamed_168;
					fragment_unnamed_208 = fragment_unnamed_169;
					fragment_unnamed_209 = fragment_unnamed_170;
					fragment_unnamed_210 = fragment_unnamed_171;
					fragment_unnamed_211 = fragment_unnamed_172;
					fragment_unnamed_212 = fragment_unnamed_173;
				}
				uint fragment_unnamed_220 = ((float(int(fragment_unnamed_212)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_181;
				float fragment_unnamed_245;
				float fragment_unnamed_246;
				float fragment_unnamed_247;
				float fragment_unnamed_248;
				float fragment_unnamed_249;
				float fragment_unnamed_250;
				uint fragment_unnamed_251;
				if (fragment_unnamed_220 != 0u)
				{
					float4 fragment_unnamed_230 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_206 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_211 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_245 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_206);
					fragment_unnamed_246 = fragment_unnamed_207 + fragment_unnamed_230.x;
					fragment_unnamed_247 = fragment_unnamed_208 + fragment_unnamed_230.y;
					fragment_unnamed_248 = fragment_unnamed_209 + fragment_unnamed_230.z;
					fragment_unnamed_249 = fragment_unnamed_210 + fragment_unnamed_230.w;
					fragment_unnamed_250 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_211);
					fragment_unnamed_251 = 5u;
				}
				else
				{
					fragment_unnamed_245 = fragment_unnamed_206;
					fragment_unnamed_246 = fragment_unnamed_207;
					fragment_unnamed_247 = fragment_unnamed_208;
					fragment_unnamed_248 = fragment_unnamed_209;
					fragment_unnamed_249 = fragment_unnamed_210;
					fragment_unnamed_250 = fragment_unnamed_211;
					fragment_unnamed_251 = fragment_unnamed_212;
				}
				uint fragment_unnamed_259 = ((float(int(fragment_unnamed_251)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_220;
				float fragment_unnamed_284;
				float fragment_unnamed_285;
				float fragment_unnamed_286;
				float fragment_unnamed_287;
				float fragment_unnamed_288;
				float fragment_unnamed_289;
				uint fragment_unnamed_290;
				if (fragment_unnamed_259 != 0u)
				{
					float4 fragment_unnamed_269 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_245 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_250 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_284 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_245);
					fragment_unnamed_285 = fragment_unnamed_246 + fragment_unnamed_269.x;
					fragment_unnamed_286 = fragment_unnamed_247 + fragment_unnamed_269.y;
					fragment_unnamed_287 = fragment_unnamed_248 + fragment_unnamed_269.z;
					fragment_unnamed_288 = fragment_unnamed_249 + fragment_unnamed_269.w;
					fragment_unnamed_289 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_250);
					fragment_unnamed_290 = 6u;
				}
				else
				{
					fragment_unnamed_284 = fragment_unnamed_245;
					fragment_unnamed_285 = fragment_unnamed_246;
					fragment_unnamed_286 = fragment_unnamed_247;
					fragment_unnamed_287 = fragment_unnamed_248;
					fragment_unnamed_288 = fragment_unnamed_249;
					fragment_unnamed_289 = fragment_unnamed_250;
					fragment_unnamed_290 = fragment_unnamed_251;
				}
				uint fragment_unnamed_298 = ((float(int(fragment_unnamed_290)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_259;
				float fragment_unnamed_323;
				float fragment_unnamed_324;
				float fragment_unnamed_325;
				float fragment_unnamed_326;
				float fragment_unnamed_327;
				float fragment_unnamed_328;
				uint fragment_unnamed_329;
				if (fragment_unnamed_298 != 0u)
				{
					float4 fragment_unnamed_308 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_284 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_289 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_323 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_284);
					fragment_unnamed_324 = fragment_unnamed_285 + fragment_unnamed_308.x;
					fragment_unnamed_325 = fragment_unnamed_286 + fragment_unnamed_308.y;
					fragment_unnamed_326 = fragment_unnamed_287 + fragment_unnamed_308.z;
					fragment_unnamed_327 = fragment_unnamed_288 + fragment_unnamed_308.w;
					fragment_unnamed_328 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_289);
					fragment_unnamed_329 = 7u;
				}
				else
				{
					fragment_unnamed_323 = fragment_unnamed_284;
					fragment_unnamed_324 = fragment_unnamed_285;
					fragment_unnamed_325 = fragment_unnamed_286;
					fragment_unnamed_326 = fragment_unnamed_287;
					fragment_unnamed_327 = fragment_unnamed_288;
					fragment_unnamed_328 = fragment_unnamed_289;
					fragment_unnamed_329 = fragment_unnamed_290;
				}
				uint fragment_unnamed_337 = ((float(int(fragment_unnamed_329)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_298;
				float fragment_unnamed_362;
				float fragment_unnamed_363;
				float fragment_unnamed_364;
				float fragment_unnamed_365;
				float fragment_unnamed_366;
				float fragment_unnamed_367;
				uint fragment_unnamed_368;
				if (fragment_unnamed_337 != 0u)
				{
					float4 fragment_unnamed_347 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_323 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_328 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_362 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_323);
					fragment_unnamed_363 = fragment_unnamed_324 + fragment_unnamed_347.x;
					fragment_unnamed_364 = fragment_unnamed_325 + fragment_unnamed_347.y;
					fragment_unnamed_365 = fragment_unnamed_326 + fragment_unnamed_347.z;
					fragment_unnamed_366 = fragment_unnamed_327 + fragment_unnamed_347.w;
					fragment_unnamed_367 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_328);
					fragment_unnamed_368 = 8u;
				}
				else
				{
					fragment_unnamed_362 = fragment_unnamed_323;
					fragment_unnamed_363 = fragment_unnamed_324;
					fragment_unnamed_364 = fragment_unnamed_325;
					fragment_unnamed_365 = fragment_unnamed_326;
					fragment_unnamed_366 = fragment_unnamed_327;
					fragment_unnamed_367 = fragment_unnamed_328;
					fragment_unnamed_368 = fragment_unnamed_329;
				}
				uint fragment_unnamed_376 = ((float(int(fragment_unnamed_368)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_337;
				float fragment_unnamed_401;
				float fragment_unnamed_402;
				float fragment_unnamed_403;
				float fragment_unnamed_404;
				float fragment_unnamed_405;
				float fragment_unnamed_406;
				uint fragment_unnamed_407;
				if (fragment_unnamed_376 != 0u)
				{
					float4 fragment_unnamed_386 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_362 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_367 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_401 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_362);
					fragment_unnamed_402 = fragment_unnamed_363 + fragment_unnamed_386.x;
					fragment_unnamed_403 = fragment_unnamed_364 + fragment_unnamed_386.y;
					fragment_unnamed_404 = fragment_unnamed_365 + fragment_unnamed_386.z;
					fragment_unnamed_405 = fragment_unnamed_366 + fragment_unnamed_386.w;
					fragment_unnamed_406 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_367);
					fragment_unnamed_407 = 9u;
				}
				else
				{
					fragment_unnamed_401 = fragment_unnamed_362;
					fragment_unnamed_402 = fragment_unnamed_363;
					fragment_unnamed_403 = fragment_unnamed_364;
					fragment_unnamed_404 = fragment_unnamed_365;
					fragment_unnamed_405 = fragment_unnamed_366;
					fragment_unnamed_406 = fragment_unnamed_367;
					fragment_unnamed_407 = fragment_unnamed_368;
				}
				uint fragment_unnamed_415 = ((float(int(fragment_unnamed_407)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_376;
				float fragment_unnamed_440;
				float fragment_unnamed_441;
				float fragment_unnamed_442;
				float fragment_unnamed_443;
				float fragment_unnamed_444;
				float fragment_unnamed_445;
				uint fragment_unnamed_446;
				if (fragment_unnamed_415 != 0u)
				{
					float4 fragment_unnamed_425 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_401 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_406 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_440 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_401);
					fragment_unnamed_441 = fragment_unnamed_402 + fragment_unnamed_425.x;
					fragment_unnamed_442 = fragment_unnamed_403 + fragment_unnamed_425.y;
					fragment_unnamed_443 = fragment_unnamed_404 + fragment_unnamed_425.z;
					fragment_unnamed_444 = fragment_unnamed_405 + fragment_unnamed_425.w;
					fragment_unnamed_445 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_406);
					fragment_unnamed_446 = 10u;
				}
				else
				{
					fragment_unnamed_440 = fragment_unnamed_401;
					fragment_unnamed_441 = fragment_unnamed_402;
					fragment_unnamed_442 = fragment_unnamed_403;
					fragment_unnamed_443 = fragment_unnamed_404;
					fragment_unnamed_444 = fragment_unnamed_405;
					fragment_unnamed_445 = fragment_unnamed_406;
					fragment_unnamed_446 = fragment_unnamed_407;
				}
				uint fragment_unnamed_454 = ((float(int(fragment_unnamed_446)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_415;
				float fragment_unnamed_479;
				float fragment_unnamed_480;
				float fragment_unnamed_481;
				float fragment_unnamed_482;
				float fragment_unnamed_483;
				float fragment_unnamed_484;
				uint fragment_unnamed_485;
				if (fragment_unnamed_454 != 0u)
				{
					float4 fragment_unnamed_464 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_440 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_445 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_479 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_440);
					fragment_unnamed_480 = fragment_unnamed_441 + fragment_unnamed_464.x;
					fragment_unnamed_481 = fragment_unnamed_442 + fragment_unnamed_464.y;
					fragment_unnamed_482 = fragment_unnamed_443 + fragment_unnamed_464.z;
					fragment_unnamed_483 = fragment_unnamed_444 + fragment_unnamed_464.w;
					fragment_unnamed_484 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_445);
					fragment_unnamed_485 = 11u;
				}
				else
				{
					fragment_unnamed_479 = fragment_unnamed_440;
					fragment_unnamed_480 = fragment_unnamed_441;
					fragment_unnamed_481 = fragment_unnamed_442;
					fragment_unnamed_482 = fragment_unnamed_443;
					fragment_unnamed_483 = fragment_unnamed_444;
					fragment_unnamed_484 = fragment_unnamed_445;
					fragment_unnamed_485 = fragment_unnamed_446;
				}
				float fragment_unnamed_513;
				float fragment_unnamed_514;
				float fragment_unnamed_515;
				float fragment_unnamed_516;
				if ((((float(int(fragment_unnamed_485)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_454) != 0u)
				{
					float4 fragment_unnamed_503 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_479 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_484 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_513 = fragment_unnamed_503.x + fragment_unnamed_480;
					fragment_unnamed_514 = fragment_unnamed_503.y + fragment_unnamed_481;
					fragment_unnamed_515 = fragment_unnamed_503.z + fragment_unnamed_482;
					fragment_unnamed_516 = fragment_unnamed_503.w + fragment_unnamed_483;
				}
				else
				{
					fragment_unnamed_513 = fragment_unnamed_480;
					fragment_unnamed_514 = fragment_unnamed_481;
					fragment_unnamed_515 = fragment_unnamed_482;
					fragment_unnamed_516 = fragment_unnamed_483;
				}
				fragment_output_0.x = fragment_unnamed_513 / fragment_uniform_buffer_0[0u].y;
				fragment_output_0.y = fragment_unnamed_514 / fragment_uniform_buffer_0[0u].y;
				fragment_output_0.z = fragment_unnamed_515 / fragment_uniform_buffer_0[0u].y;
				fragment_output_0.w = fragment_unnamed_516 / fragment_uniform_buffer_0[0u].y;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Amount, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], _Iterations, fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_1[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

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


			float _Amount;
			float _Iterations;
			float4 _RTHandleScale;

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[53];
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
				float fragment_unnamed_42 = ((-0.0f) - fragment_input_1.x) + 0.5f;
				float fragment_unnamed_44 = ((-0.0f) - fragment_input_1.y) + 0.5f;
				float fragment_unnamed_91;
				float fragment_unnamed_92;
				float fragment_unnamed_93;
				float fragment_unnamed_94;
				float fragment_unnamed_95;
				float fragment_unnamed_96;
				uint fragment_unnamed_97;
				if (0.0f < fragment_uniform_buffer_0[0u].y)
				{
					float4 fragment_unnamed_66 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_input_1.x * fragment_uniform_buffer_1[52u].x, fragment_input_1.y * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_91 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_input_1.x);
					fragment_unnamed_92 = fragment_unnamed_66.x;
					fragment_unnamed_93 = fragment_unnamed_66.y;
					fragment_unnamed_94 = fragment_unnamed_66.z;
					fragment_unnamed_95 = fragment_unnamed_66.w;
					fragment_unnamed_96 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_input_1.y);
					fragment_unnamed_97 = 1u;
				}
				else
				{
					fragment_unnamed_91 = fragment_input_1.x;
					fragment_unnamed_92 = asfloat(0u);
					fragment_unnamed_93 = asfloat(0u);
					fragment_unnamed_94 = asfloat(0u);
					fragment_unnamed_95 = asfloat(0u);
					fragment_unnamed_96 = fragment_input_1.y;
					fragment_unnamed_97 = 0u;
				}
				bool fragment_unnamed_102 = float(int(fragment_unnamed_97)) < fragment_uniform_buffer_0[0u].y;
				float fragment_unnamed_128;
				float fragment_unnamed_129;
				float fragment_unnamed_130;
				float fragment_unnamed_131;
				float fragment_unnamed_132;
				float fragment_unnamed_133;
				uint fragment_unnamed_134;
				if (fragment_unnamed_102)
				{
					float4 fragment_unnamed_113 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_91 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_96 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_128 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_91);
					fragment_unnamed_129 = fragment_unnamed_92 + fragment_unnamed_113.x;
					fragment_unnamed_130 = fragment_unnamed_93 + fragment_unnamed_113.y;
					fragment_unnamed_131 = fragment_unnamed_94 + fragment_unnamed_113.z;
					fragment_unnamed_132 = fragment_unnamed_95 + fragment_unnamed_113.w;
					fragment_unnamed_133 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_96);
					fragment_unnamed_134 = 2u;
				}
				else
				{
					fragment_unnamed_128 = fragment_unnamed_91;
					fragment_unnamed_129 = fragment_unnamed_92;
					fragment_unnamed_130 = fragment_unnamed_93;
					fragment_unnamed_131 = fragment_unnamed_94;
					fragment_unnamed_132 = fragment_unnamed_95;
					fragment_unnamed_133 = fragment_unnamed_96;
					fragment_unnamed_134 = fragment_unnamed_97;
				}
				uint fragment_unnamed_142 = ((float(int(fragment_unnamed_134)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & (fragment_unnamed_102 ? 4294967295u : 0u);
				float fragment_unnamed_167;
				float fragment_unnamed_168;
				float fragment_unnamed_169;
				float fragment_unnamed_170;
				float fragment_unnamed_171;
				float fragment_unnamed_172;
				uint fragment_unnamed_173;
				if (fragment_unnamed_142 != 0u)
				{
					float4 fragment_unnamed_152 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_128 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_133 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_167 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_128);
					fragment_unnamed_168 = fragment_unnamed_129 + fragment_unnamed_152.x;
					fragment_unnamed_169 = fragment_unnamed_130 + fragment_unnamed_152.y;
					fragment_unnamed_170 = fragment_unnamed_131 + fragment_unnamed_152.z;
					fragment_unnamed_171 = fragment_unnamed_132 + fragment_unnamed_152.w;
					fragment_unnamed_172 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_133);
					fragment_unnamed_173 = 3u;
				}
				else
				{
					fragment_unnamed_167 = fragment_unnamed_128;
					fragment_unnamed_168 = fragment_unnamed_129;
					fragment_unnamed_169 = fragment_unnamed_130;
					fragment_unnamed_170 = fragment_unnamed_131;
					fragment_unnamed_171 = fragment_unnamed_132;
					fragment_unnamed_172 = fragment_unnamed_133;
					fragment_unnamed_173 = fragment_unnamed_134;
				}
				uint fragment_unnamed_181 = ((float(int(fragment_unnamed_173)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_142;
				float fragment_unnamed_206;
				float fragment_unnamed_207;
				float fragment_unnamed_208;
				float fragment_unnamed_209;
				float fragment_unnamed_210;
				float fragment_unnamed_211;
				uint fragment_unnamed_212;
				if (fragment_unnamed_181 != 0u)
				{
					float4 fragment_unnamed_191 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_167 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_172 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_206 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_167);
					fragment_unnamed_207 = fragment_unnamed_168 + fragment_unnamed_191.x;
					fragment_unnamed_208 = fragment_unnamed_169 + fragment_unnamed_191.y;
					fragment_unnamed_209 = fragment_unnamed_170 + fragment_unnamed_191.z;
					fragment_unnamed_210 = fragment_unnamed_171 + fragment_unnamed_191.w;
					fragment_unnamed_211 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_172);
					fragment_unnamed_212 = 4u;
				}
				else
				{
					fragment_unnamed_206 = fragment_unnamed_167;
					fragment_unnamed_207 = fragment_unnamed_168;
					fragment_unnamed_208 = fragment_unnamed_169;
					fragment_unnamed_209 = fragment_unnamed_170;
					fragment_unnamed_210 = fragment_unnamed_171;
					fragment_unnamed_211 = fragment_unnamed_172;
					fragment_unnamed_212 = fragment_unnamed_173;
				}
				uint fragment_unnamed_220 = ((float(int(fragment_unnamed_212)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_181;
				float fragment_unnamed_245;
				float fragment_unnamed_246;
				float fragment_unnamed_247;
				float fragment_unnamed_248;
				float fragment_unnamed_249;
				float fragment_unnamed_250;
				uint fragment_unnamed_251;
				if (fragment_unnamed_220 != 0u)
				{
					float4 fragment_unnamed_230 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_206 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_211 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_245 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_206);
					fragment_unnamed_246 = fragment_unnamed_207 + fragment_unnamed_230.x;
					fragment_unnamed_247 = fragment_unnamed_208 + fragment_unnamed_230.y;
					fragment_unnamed_248 = fragment_unnamed_209 + fragment_unnamed_230.z;
					fragment_unnamed_249 = fragment_unnamed_210 + fragment_unnamed_230.w;
					fragment_unnamed_250 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_211);
					fragment_unnamed_251 = 5u;
				}
				else
				{
					fragment_unnamed_245 = fragment_unnamed_206;
					fragment_unnamed_246 = fragment_unnamed_207;
					fragment_unnamed_247 = fragment_unnamed_208;
					fragment_unnamed_248 = fragment_unnamed_209;
					fragment_unnamed_249 = fragment_unnamed_210;
					fragment_unnamed_250 = fragment_unnamed_211;
					fragment_unnamed_251 = fragment_unnamed_212;
				}
				uint fragment_unnamed_259 = ((float(int(fragment_unnamed_251)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_220;
				float fragment_unnamed_284;
				float fragment_unnamed_285;
				float fragment_unnamed_286;
				float fragment_unnamed_287;
				float fragment_unnamed_288;
				float fragment_unnamed_289;
				uint fragment_unnamed_290;
				if (fragment_unnamed_259 != 0u)
				{
					float4 fragment_unnamed_269 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_245 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_250 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_284 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_245);
					fragment_unnamed_285 = fragment_unnamed_246 + fragment_unnamed_269.x;
					fragment_unnamed_286 = fragment_unnamed_247 + fragment_unnamed_269.y;
					fragment_unnamed_287 = fragment_unnamed_248 + fragment_unnamed_269.z;
					fragment_unnamed_288 = fragment_unnamed_249 + fragment_unnamed_269.w;
					fragment_unnamed_289 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_250);
					fragment_unnamed_290 = 6u;
				}
				else
				{
					fragment_unnamed_284 = fragment_unnamed_245;
					fragment_unnamed_285 = fragment_unnamed_246;
					fragment_unnamed_286 = fragment_unnamed_247;
					fragment_unnamed_287 = fragment_unnamed_248;
					fragment_unnamed_288 = fragment_unnamed_249;
					fragment_unnamed_289 = fragment_unnamed_250;
					fragment_unnamed_290 = fragment_unnamed_251;
				}
				uint fragment_unnamed_298 = ((float(int(fragment_unnamed_290)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_259;
				float fragment_unnamed_323;
				float fragment_unnamed_324;
				float fragment_unnamed_325;
				float fragment_unnamed_326;
				float fragment_unnamed_327;
				float fragment_unnamed_328;
				uint fragment_unnamed_329;
				if (fragment_unnamed_298 != 0u)
				{
					float4 fragment_unnamed_308 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_284 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_289 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_323 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_284);
					fragment_unnamed_324 = fragment_unnamed_285 + fragment_unnamed_308.x;
					fragment_unnamed_325 = fragment_unnamed_286 + fragment_unnamed_308.y;
					fragment_unnamed_326 = fragment_unnamed_287 + fragment_unnamed_308.z;
					fragment_unnamed_327 = fragment_unnamed_288 + fragment_unnamed_308.w;
					fragment_unnamed_328 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_289);
					fragment_unnamed_329 = 7u;
				}
				else
				{
					fragment_unnamed_323 = fragment_unnamed_284;
					fragment_unnamed_324 = fragment_unnamed_285;
					fragment_unnamed_325 = fragment_unnamed_286;
					fragment_unnamed_326 = fragment_unnamed_287;
					fragment_unnamed_327 = fragment_unnamed_288;
					fragment_unnamed_328 = fragment_unnamed_289;
					fragment_unnamed_329 = fragment_unnamed_290;
				}
				uint fragment_unnamed_337 = ((float(int(fragment_unnamed_329)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_298;
				float fragment_unnamed_362;
				float fragment_unnamed_363;
				float fragment_unnamed_364;
				float fragment_unnamed_365;
				float fragment_unnamed_366;
				float fragment_unnamed_367;
				uint fragment_unnamed_368;
				if (fragment_unnamed_337 != 0u)
				{
					float4 fragment_unnamed_347 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_323 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_328 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_362 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_323);
					fragment_unnamed_363 = fragment_unnamed_324 + fragment_unnamed_347.x;
					fragment_unnamed_364 = fragment_unnamed_325 + fragment_unnamed_347.y;
					fragment_unnamed_365 = fragment_unnamed_326 + fragment_unnamed_347.z;
					fragment_unnamed_366 = fragment_unnamed_327 + fragment_unnamed_347.w;
					fragment_unnamed_367 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_328);
					fragment_unnamed_368 = 8u;
				}
				else
				{
					fragment_unnamed_362 = fragment_unnamed_323;
					fragment_unnamed_363 = fragment_unnamed_324;
					fragment_unnamed_364 = fragment_unnamed_325;
					fragment_unnamed_365 = fragment_unnamed_326;
					fragment_unnamed_366 = fragment_unnamed_327;
					fragment_unnamed_367 = fragment_unnamed_328;
					fragment_unnamed_368 = fragment_unnamed_329;
				}
				uint fragment_unnamed_376 = ((float(int(fragment_unnamed_368)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_337;
				float fragment_unnamed_401;
				float fragment_unnamed_402;
				float fragment_unnamed_403;
				float fragment_unnamed_404;
				float fragment_unnamed_405;
				float fragment_unnamed_406;
				uint fragment_unnamed_407;
				if (fragment_unnamed_376 != 0u)
				{
					float4 fragment_unnamed_386 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_362 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_367 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_401 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_362);
					fragment_unnamed_402 = fragment_unnamed_363 + fragment_unnamed_386.x;
					fragment_unnamed_403 = fragment_unnamed_364 + fragment_unnamed_386.y;
					fragment_unnamed_404 = fragment_unnamed_365 + fragment_unnamed_386.z;
					fragment_unnamed_405 = fragment_unnamed_366 + fragment_unnamed_386.w;
					fragment_unnamed_406 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_367);
					fragment_unnamed_407 = 9u;
				}
				else
				{
					fragment_unnamed_401 = fragment_unnamed_362;
					fragment_unnamed_402 = fragment_unnamed_363;
					fragment_unnamed_403 = fragment_unnamed_364;
					fragment_unnamed_404 = fragment_unnamed_365;
					fragment_unnamed_405 = fragment_unnamed_366;
					fragment_unnamed_406 = fragment_unnamed_367;
					fragment_unnamed_407 = fragment_unnamed_368;
				}
				uint fragment_unnamed_415 = ((float(int(fragment_unnamed_407)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_376;
				float fragment_unnamed_440;
				float fragment_unnamed_441;
				float fragment_unnamed_442;
				float fragment_unnamed_443;
				float fragment_unnamed_444;
				float fragment_unnamed_445;
				uint fragment_unnamed_446;
				if (fragment_unnamed_415 != 0u)
				{
					float4 fragment_unnamed_425 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_401 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_406 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_440 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_401);
					fragment_unnamed_441 = fragment_unnamed_402 + fragment_unnamed_425.x;
					fragment_unnamed_442 = fragment_unnamed_403 + fragment_unnamed_425.y;
					fragment_unnamed_443 = fragment_unnamed_404 + fragment_unnamed_425.z;
					fragment_unnamed_444 = fragment_unnamed_405 + fragment_unnamed_425.w;
					fragment_unnamed_445 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_406);
					fragment_unnamed_446 = 10u;
				}
				else
				{
					fragment_unnamed_440 = fragment_unnamed_401;
					fragment_unnamed_441 = fragment_unnamed_402;
					fragment_unnamed_442 = fragment_unnamed_403;
					fragment_unnamed_443 = fragment_unnamed_404;
					fragment_unnamed_444 = fragment_unnamed_405;
					fragment_unnamed_445 = fragment_unnamed_406;
					fragment_unnamed_446 = fragment_unnamed_407;
				}
				uint fragment_unnamed_454 = ((float(int(fragment_unnamed_446)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_415;
				float fragment_unnamed_479;
				float fragment_unnamed_480;
				float fragment_unnamed_481;
				float fragment_unnamed_482;
				float fragment_unnamed_483;
				float fragment_unnamed_484;
				uint fragment_unnamed_485;
				if (fragment_unnamed_454 != 0u)
				{
					float4 fragment_unnamed_464 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_440 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_445 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_479 = mad(fragment_unnamed_42, fragment_uniform_buffer_0[0u].x, fragment_unnamed_440);
					fragment_unnamed_480 = fragment_unnamed_441 + fragment_unnamed_464.x;
					fragment_unnamed_481 = fragment_unnamed_442 + fragment_unnamed_464.y;
					fragment_unnamed_482 = fragment_unnamed_443 + fragment_unnamed_464.z;
					fragment_unnamed_483 = fragment_unnamed_444 + fragment_unnamed_464.w;
					fragment_unnamed_484 = mad(fragment_unnamed_44, fragment_uniform_buffer_0[0u].x, fragment_unnamed_445);
					fragment_unnamed_485 = 11u;
				}
				else
				{
					fragment_unnamed_479 = fragment_unnamed_440;
					fragment_unnamed_480 = fragment_unnamed_441;
					fragment_unnamed_481 = fragment_unnamed_442;
					fragment_unnamed_482 = fragment_unnamed_443;
					fragment_unnamed_483 = fragment_unnamed_444;
					fragment_unnamed_484 = fragment_unnamed_445;
					fragment_unnamed_485 = fragment_unnamed_446;
				}
				float fragment_unnamed_513;
				float fragment_unnamed_514;
				float fragment_unnamed_515;
				float fragment_unnamed_516;
				if ((((float(int(fragment_unnamed_485)) < fragment_uniform_buffer_0[0u].y) ? 4294967295u : 0u) & fragment_unnamed_454) != 0u)
				{
					float4 fragment_unnamed_503 = _MainTex.Sample(sampler_linear_clamp_S0, float3(fragment_unnamed_479 * fragment_uniform_buffer_1[52u].x, fragment_unnamed_484 * fragment_uniform_buffer_1[52u].y, asfloat(0u)));
					fragment_unnamed_513 = fragment_unnamed_503.x + fragment_unnamed_480;
					fragment_unnamed_514 = fragment_unnamed_503.y + fragment_unnamed_481;
					fragment_unnamed_515 = fragment_unnamed_503.z + fragment_unnamed_482;
					fragment_unnamed_516 = fragment_unnamed_503.w + fragment_unnamed_483;
				}
				else
				{
					fragment_unnamed_513 = fragment_unnamed_480;
					fragment_unnamed_514 = fragment_unnamed_481;
					fragment_unnamed_515 = fragment_unnamed_482;
					fragment_unnamed_516 = fragment_unnamed_483;
				}
				fragment_output_0.x = fragment_unnamed_513 / fragment_uniform_buffer_0[0u].y;
				fragment_output_0.y = fragment_unnamed_514 / fragment_uniform_buffer_0[0u].y;
				fragment_output_0.z = fragment_unnamed_515 / fragment_uniform_buffer_0[0u].y;
				fragment_output_0.w = fragment_unnamed_516 / fragment_uniform_buffer_0[0u].y;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_Amount, fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_0[0] = float4(fragment_uniform_buffer_0[0][0], _Iterations, fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_1[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

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
