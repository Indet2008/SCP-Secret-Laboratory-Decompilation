Shader "Hidden/Shader/TiltShift"
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
			Name "Tilt Shift: Horizontal"
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
			GpuProgramID 25853

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


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


			float4 _Params;
			float _Offset;
			float _Angle;

			static float4 fragment_uniform_buffer_0[6];
			static const float fragment_unnamed_53[48] = { -0.326211988925933837890625f, -0.40580999851226806640625f, 0.0f, 0.0f, -0.840143978595733642578125f, -0.0735799968242645263671875f, 0.0f, 0.0f, -0.695913970470428466796875f, 0.45713698863983154296875f, 0.0f, 0.0f, -0.203345000743865966796875f, 0.62071597576141357421875f, 0.0f, 0.0f, 0.96233999729156494140625f, -0.194983005523681640625f, 0.0f, 0.0f, 0.4734340012073516845703125f, -0.4800260066986083984375f, 0.0f, 0.0f, 0.51945602893829345703125f, 0.76702201366424560546875f, 0.0f, 0.0f, 0.18546099960803985595703125f, -0.89312398433685302734375f, 0.0f, 0.0f, 0.507430970668792724609375f, 0.064424999058246612548828125f, 0.0f, 0.0f, 0.896420001983642578125f, 0.412458002567291259765625f, 0.0f, 0.0f, -0.321940004825592041015625f, -0.932614982128143310546875f, 0.0f, 0.0f, -0.7915589809417724609375f, -0.59771001338958740234375f, 0.0f, 0.0f };

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
				float fragment_unnamed_109 = clamp((1.0f / fragment_uniform_buffer_0[4u].y) * (min(abs(mad(clamp(dot(float2(fragment_input_1.x + (-0.5f), fragment_input_1.y + (-0.5f)), float2(sin((-0.0f) - fragment_uniform_buffer_0[5u].y), cos(fragment_uniform_buffer_0[5u].y))) + 0.5f, 0.0f, 1.0f), 2.0f, -1.0f) + ((-0.0f) - fragment_uniform_buffer_0[5u].x)), 1.0f) + ((-0.0f) - fragment_uniform_buffer_0[4u].x)), 0.0f, 1.0f);
				float fragment_unnamed_116 = min((fragment_unnamed_109 * fragment_unnamed_109) * mad(fragment_unnamed_109, -2.0f, 3.0f), 1.0f) * 0.00999999977648258209228515625f;
				float fragment_unnamed_121 = fragment_unnamed_116 * fragment_uniform_buffer_0[4u].z;
				float fragment_unnamed_122 = asfloat(0u);
				float fragment_unnamed_126;
				float fragment_unnamed_128;
				float fragment_unnamed_130;
				fragment_unnamed_126 = asfloat(0u);
				fragment_unnamed_128 = asfloat(0u);
				fragment_unnamed_130 = asfloat(0u);
				float4 fragment_unnamed_165;
				float fragment_unnamed_168;
				float fragment_unnamed_169;
				float fragment_unnamed_170;
				for (uint fragment_unnamed_132 = 0u; !(int(fragment_unnamed_132) >= int(12u)); fragment_unnamed_165 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(mad(fragment_unnamed_53[(fragment_unnamed_132 * 4u) + 0u], fragment_unnamed_121, fragment_input_1.x), mad(fragment_unnamed_53[(fragment_unnamed_132 * 4u) + 1u], fragment_unnamed_121, fragment_input_1.y), fragment_unnamed_122)), fragment_unnamed_168 = fragment_unnamed_165.x, fragment_unnamed_169 = fragment_unnamed_165.y, fragment_unnamed_170 = fragment_unnamed_165.z, fragment_unnamed_126 = fragment_unnamed_168 + fragment_unnamed_126, fragment_unnamed_128 = fragment_unnamed_169 + fragment_unnamed_128, fragment_unnamed_130 = fragment_unnamed_170 + fragment_unnamed_130, fragment_unnamed_132++)
				{
				}
				fragment_output_0.x = fragment_unnamed_126 * 0.083333335816860198974609375f;
				fragment_output_0.y = fragment_unnamed_128 * 0.083333335816860198974609375f;
				fragment_output_0.z = fragment_unnamed_130 * 0.083333335816860198974609375f;
				fragment_output_0.w = fragment_unnamed_116;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				fragment_uniform_buffer_0[5] = float4(_Offset, fragment_uniform_buffer_0[5][1], fragment_uniform_buffer_0[5][2], fragment_uniform_buffer_0[5][3]);

				fragment_uniform_buffer_0[5] = float4(fragment_uniform_buffer_0[5][0], _Angle, fragment_uniform_buffer_0[5][2], fragment_uniform_buffer_0[5][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
		Pass
		{
			Name "Tilt Shift: Horizontal (HQ)"
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
			GpuProgramID 90114

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


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


			float4 _Params;
			float _Offset;
			float _Angle;

			static float4 fragment_uniform_buffer_0[6];
			static const float fragment_unnamed_113[112] = { 0.624629974365234375f, 0.5433700084686279296875f, 0.827899992465972900390625f, 0.0f, -0.13413999974727630615234375f, -0.944880008697509765625f, 0.954349994659423828125f, 0.0f, 0.38771998882293701171875f, -0.4347499907016754150390625f, 0.58253002166748046875f, 0.0f, 0.12126000225543975830078125f, -0.19281999766826629638671875f, 0.22777999937534332275390625f, 0.0f, -0.20387999713420867919921875f, 0.1113300025463104248046875f, 0.23229999840259552001953125f, 0.0f, 0.831139981746673583984375f, -0.292180001735687255859375f, 0.880999982357025146484375f, 0.0f, 0.107589997351169586181640625f, -0.57839000225067138671875f, 0.5883100032806396484375f, 0.0f, 0.2828499972820281982421875f, 0.790359973907470703125f, 0.83945000171661376953125f, 0.0f, -0.366219997406005859375f, 0.3951599895954132080078125f, 0.538760006427764892578125f, 0.0f, 0.755909979343414306640625f, 0.21916000545024871826171875f, 0.7870399951934814453125f, 0.0f, -0.526099979877471923828125f, 0.023860000073909759521484375f, 0.526639997959136962890625f, 0.0f, -0.882160007953643798828125f, -0.2447099983692169189453125f, 0.91547000408172607421875f, 0.0f, -0.4888800084590911865234375f, -0.2933000028133392333984375f, 0.570110023021697998046875f, 0.0f, 0.4401400089263916015625f, -0.085579998791217803955078125f, 0.448379993438720703125f, 0.0f, 0.2117899954319000244140625f, 0.513729989528656005859375f, 0.5556700229644775390625f, 0.0f, 0.05482999980449676513671875f, 0.957009971141815185546875f, 0.95858001708984375f, 0.0f, -0.590009987354278564453125f, -0.705089986324310302734375f, 0.919380009174346923828125f, 0.0f, -0.80065000057220458984375f, 0.2463099956512451171875f, 0.83767998218536376953125f, 0.0f, -0.1942400038242340087890625f, -0.18401999771595001220703125f, 0.2675699889659881591796875f, 0.0f, -0.436670005321502685546875f, 0.767509996891021728515625f, 0.883040010929107666015625f, 0.0f, 0.2166599929332733154296875f, 0.116020001471042633056640625f, 0.2457700073719024658203125f, 0.0f, 0.15695999562740325927734375f, -0.856000006198883056640625f, 0.8702700138092041015625f, 0.0f, -0.758210003376007080078125f, 0.583630025386810302734375f, 0.956820011138916015625f, 0.0f, 0.992839992046356201171875f, -0.02903999947011470794677734375f, 0.993269979953765869140625f, 0.0f, -0.22234000265598297119140625f, -0.57906997203826904296875f, 0.620289981365203857421875f, 0.0f, 0.550520002841949462890625f, -0.66983997821807861328125f, 0.867039978504180908203125f, 0.0f, 0.464309990406036376953125f, 0.2811500132083892822265625f, 0.542800009250640869140625f, 0.0f, -0.072140000760555267333984375f, 0.605539977550506591796875f, 0.60982000827789306640625f, 0.0f };

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
				float fragment_unnamed_169 = clamp((1.0f / fragment_uniform_buffer_0[4u].y) * (min(abs(mad(clamp(dot(float2(fragment_input_1.x + (-0.5f), fragment_input_1.y + (-0.5f)), float2(sin((-0.0f) - fragment_uniform_buffer_0[5u].y), cos(fragment_uniform_buffer_0[5u].y))) + 0.5f, 0.0f, 1.0f), 2.0f, -1.0f) + ((-0.0f) - fragment_uniform_buffer_0[5u].x)), 1.0f) + ((-0.0f) - fragment_uniform_buffer_0[4u].x)), 0.0f, 1.0f);
				float fragment_unnamed_176 = min((fragment_unnamed_169 * fragment_unnamed_169) * mad(fragment_unnamed_169, -2.0f, 3.0f), 1.0f) * 0.00999999977648258209228515625f;
				float fragment_unnamed_181 = fragment_unnamed_176 * fragment_uniform_buffer_0[4u].z;
				float fragment_unnamed_182 = asfloat(0u);
				float fragment_unnamed_186;
				float fragment_unnamed_188;
				float fragment_unnamed_190;
				fragment_unnamed_186 = asfloat(0u);
				fragment_unnamed_188 = asfloat(0u);
				fragment_unnamed_190 = asfloat(0u);
				float4 fragment_unnamed_225;
				float fragment_unnamed_228;
				float fragment_unnamed_229;
				float fragment_unnamed_230;
				for (uint fragment_unnamed_192 = 0u; !(int(fragment_unnamed_192) >= int(28u)); fragment_unnamed_225 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(mad(fragment_unnamed_113[(fragment_unnamed_192 * 4u) + 0u], fragment_unnamed_181, fragment_input_1.x), mad(fragment_unnamed_113[(fragment_unnamed_192 * 4u) + 1u], fragment_unnamed_181, fragment_input_1.y), fragment_unnamed_182)), fragment_unnamed_228 = fragment_unnamed_225.x, fragment_unnamed_229 = fragment_unnamed_225.y, fragment_unnamed_230 = fragment_unnamed_225.z, fragment_unnamed_186 = fragment_unnamed_228 + fragment_unnamed_186, fragment_unnamed_188 = fragment_unnamed_229 + fragment_unnamed_188, fragment_unnamed_190 = fragment_unnamed_230 + fragment_unnamed_190, fragment_unnamed_192++)
				{
				}
				fragment_output_0.x = fragment_unnamed_186 * 0.0357142873108386993408203125f;
				fragment_output_0.y = fragment_unnamed_188 * 0.0357142873108386993408203125f;
				fragment_output_0.z = fragment_unnamed_190 * 0.0357142873108386993408203125f;
				fragment_output_0.w = fragment_unnamed_176;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				fragment_uniform_buffer_0[5] = float4(_Offset, fragment_uniform_buffer_0[5][1], fragment_uniform_buffer_0[5][2], fragment_uniform_buffer_0[5][3]);

				fragment_uniform_buffer_0[5] = float4(fragment_uniform_buffer_0[5][0], _Angle, fragment_uniform_buffer_0[5][2], fragment_uniform_buffer_0[5][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
		Pass
		{
			Name "Tilt Shift: Radial"
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
			GpuProgramID 166885

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


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


			float4 _Params;

			static float4 fragment_uniform_buffer_0[5];
			static const float fragment_unnamed_53[48] = { -0.326211988925933837890625f, -0.40580999851226806640625f, 0.0f, 0.0f, -0.840143978595733642578125f, -0.0735799968242645263671875f, 0.0f, 0.0f, -0.695913970470428466796875f, 0.45713698863983154296875f, 0.0f, 0.0f, -0.203345000743865966796875f, 0.62071597576141357421875f, 0.0f, 0.0f, 0.96233999729156494140625f, -0.194983005523681640625f, 0.0f, 0.0f, 0.4734340012073516845703125f, -0.4800260066986083984375f, 0.0f, 0.0f, 0.51945602893829345703125f, 0.76702201366424560546875f, 0.0f, 0.0f, 0.18546099960803985595703125f, -0.89312398433685302734375f, 0.0f, 0.0f, 0.507430970668792724609375f, 0.064424999058246612548828125f, 0.0f, 0.0f, 0.896420001983642578125f, 0.412458002567291259765625f, 0.0f, 0.0f, -0.321940004825592041015625f, -0.932614982128143310546875f, 0.0f, 0.0f, -0.7915589809417724609375f, -0.59771001338958740234375f, 0.0f, 0.0f };

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
				float fragment_unnamed_66 = mad(fragment_input_1.x, 2.0f, -1.0f);
				float fragment_unnamed_69 = mad(fragment_input_1.y, 2.0f, -1.0f);
				float fragment_unnamed_88 = clamp((1.0f / fragment_uniform_buffer_0[4u].y) * (sqrt(dot(float2(fragment_unnamed_66, fragment_unnamed_69), float2(fragment_unnamed_66, fragment_unnamed_69))) + ((-0.0f) - fragment_uniform_buffer_0[4u].x)), 0.0f, 1.0f);
				float fragment_unnamed_95 = min((fragment_unnamed_88 * fragment_unnamed_88) * mad(fragment_unnamed_88, -2.0f, 3.0f), 1.0f) * 0.00999999977648258209228515625f;
				float fragment_unnamed_101 = (fragment_unnamed_95 * fragment_uniform_buffer_0[4u].z) * 0.5f;
				float fragment_unnamed_103 = asfloat(0u);
				float fragment_unnamed_107;
				float fragment_unnamed_111;
				float fragment_unnamed_113;
				fragment_unnamed_107 = asfloat(0u);
				fragment_unnamed_111 = asfloat(0u);
				fragment_unnamed_113 = asfloat(0u);
				uint fragment_unnamed_129;
				uint fragment_unnamed_134;
				float4 fragment_unnamed_146;
				for (uint fragment_unnamed_109 = 0u; !(int(fragment_unnamed_109) >= int(12u)); fragment_unnamed_129 = fragment_unnamed_109 * 4u, fragment_unnamed_134 = fragment_unnamed_109 * 4u, fragment_unnamed_146 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(mad(fragment_unnamed_53[fragment_unnamed_129 + 0u], fragment_unnamed_101, fragment_input_1.x), mad(fragment_unnamed_53[fragment_unnamed_134 + 1u], fragment_unnamed_101, fragment_input_1.y), fragment_unnamed_103)), fragment_unnamed_107 = fragment_unnamed_146.z + fragment_unnamed_107, fragment_unnamed_109++, fragment_unnamed_111 = fragment_unnamed_146.y + fragment_unnamed_111, fragment_unnamed_113 = fragment_unnamed_146.x + fragment_unnamed_113)
				{
				}
				fragment_output_0.x = fragment_unnamed_113 * 0.083333335816860198974609375f;
				fragment_output_0.y = fragment_unnamed_111 * 0.083333335816860198974609375f;
				fragment_output_0.z = fragment_unnamed_107 * 0.083333335816860198974609375f;
				fragment_output_0.w = fragment_unnamed_95;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
		Pass
		{
			Name "Tilt Shift: Radial (HQ)"
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
			GpuProgramID 259274

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


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


			float4 _Params;
			float4 _RTHandleScale;

			static float4 fragment_uniform_buffer_0[5];
			static float4 fragment_uniform_buffer_1[53];
			static const float fragment_unnamed_118[112] = { 0.624629974365234375f, 0.5433700084686279296875f, 0.827899992465972900390625f, 0.0f, -0.13413999974727630615234375f, -0.944880008697509765625f, 0.954349994659423828125f, 0.0f, 0.38771998882293701171875f, -0.4347499907016754150390625f, 0.58253002166748046875f, 0.0f, 0.12126000225543975830078125f, -0.19281999766826629638671875f, 0.22777999937534332275390625f, 0.0f, -0.20387999713420867919921875f, 0.1113300025463104248046875f, 0.23229999840259552001953125f, 0.0f, 0.831139981746673583984375f, -0.292180001735687255859375f, 0.880999982357025146484375f, 0.0f, 0.107589997351169586181640625f, -0.57839000225067138671875f, 0.5883100032806396484375f, 0.0f, 0.2828499972820281982421875f, 0.790359973907470703125f, 0.83945000171661376953125f, 0.0f, -0.366219997406005859375f, 0.3951599895954132080078125f, 0.538760006427764892578125f, 0.0f, 0.755909979343414306640625f, 0.21916000545024871826171875f, 0.7870399951934814453125f, 0.0f, -0.526099979877471923828125f, 0.023860000073909759521484375f, 0.526639997959136962890625f, 0.0f, -0.882160007953643798828125f, -0.2447099983692169189453125f, 0.91547000408172607421875f, 0.0f, -0.4888800084590911865234375f, -0.2933000028133392333984375f, 0.570110023021697998046875f, 0.0f, 0.4401400089263916015625f, -0.085579998791217803955078125f, 0.448379993438720703125f, 0.0f, 0.2117899954319000244140625f, 0.513729989528656005859375f, 0.5556700229644775390625f, 0.0f, 0.05482999980449676513671875f, 0.957009971141815185546875f, 0.95858001708984375f, 0.0f, -0.590009987354278564453125f, -0.705089986324310302734375f, 0.919380009174346923828125f, 0.0f, -0.80065000057220458984375f, 0.2463099956512451171875f, 0.83767998218536376953125f, 0.0f, -0.1942400038242340087890625f, -0.18401999771595001220703125f, 0.2675699889659881591796875f, 0.0f, -0.436670005321502685546875f, 0.767509996891021728515625f, 0.883040010929107666015625f, 0.0f, 0.2166599929332733154296875f, 0.116020001471042633056640625f, 0.2457700073719024658203125f, 0.0f, 0.15695999562740325927734375f, -0.856000006198883056640625f, 0.8702700138092041015625f, 0.0f, -0.758210003376007080078125f, 0.583630025386810302734375f, 0.956820011138916015625f, 0.0f, 0.992839992046356201171875f, -0.02903999947011470794677734375f, 0.993269979953765869140625f, 0.0f, -0.22234000265598297119140625f, -0.57906997203826904296875f, 0.620289981365203857421875f, 0.0f, 0.550520002841949462890625f, -0.66983997821807861328125f, 0.867039978504180908203125f, 0.0f, 0.464309990406036376953125f, 0.2811500132083892822265625f, 0.542800009250640869140625f, 0.0f, -0.072140000760555267333984375f, 0.605539977550506591796875f, 0.60982000827789306640625f, 0.0f };

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
				float fragment_unnamed_139 = mad(fragment_input_1.x / fragment_uniform_buffer_1[52u].x, 2.0f, -1.0f);
				float fragment_unnamed_142 = mad(fragment_input_1.y / fragment_uniform_buffer_1[52u].y, 2.0f, -1.0f);
				float fragment_unnamed_160 = clamp((1.0f / fragment_uniform_buffer_0[4u].y) * (sqrt(dot(float2(fragment_unnamed_139, fragment_unnamed_142), float2(fragment_unnamed_139, fragment_unnamed_142))) + ((-0.0f) - fragment_uniform_buffer_0[4u].x)), 0.0f, 1.0f);
				float fragment_unnamed_167 = min((fragment_unnamed_160 * fragment_unnamed_160) * mad(fragment_unnamed_160, -2.0f, 3.0f), 1.0f) * 0.00999999977648258209228515625f;
				float fragment_unnamed_172 = fragment_unnamed_167 * fragment_uniform_buffer_0[4u].z;
				float fragment_unnamed_173 = asfloat(0u);
				float fragment_unnamed_177;
				float fragment_unnamed_181;
				float fragment_unnamed_183;
				fragment_unnamed_177 = asfloat(0u);
				fragment_unnamed_181 = asfloat(0u);
				fragment_unnamed_183 = asfloat(0u);
				uint fragment_unnamed_199;
				uint fragment_unnamed_204;
				float4 fragment_unnamed_216;
				for (uint fragment_unnamed_179 = 0u; !(int(fragment_unnamed_179) >= int(28u)); fragment_unnamed_199 = fragment_unnamed_179 * 4u, fragment_unnamed_204 = fragment_unnamed_179 * 4u, fragment_unnamed_216 = _BlitTexture.Sample(sampler_linear_clamp_S0, float3(mad(fragment_unnamed_118[fragment_unnamed_199 + 0u], fragment_unnamed_172, fragment_input_1.x), mad(fragment_unnamed_118[fragment_unnamed_204 + 1u], fragment_unnamed_172, fragment_input_1.y), fragment_unnamed_173)), fragment_unnamed_177 = fragment_unnamed_216.z + fragment_unnamed_177, fragment_unnamed_179++, fragment_unnamed_181 = fragment_unnamed_216.y + fragment_unnamed_181, fragment_unnamed_183 = fragment_unnamed_216.x + fragment_unnamed_183)
				{
				}
				fragment_output_0.x = fragment_unnamed_183 * 0.0357142873108386993408203125f;
				fragment_output_0.y = fragment_unnamed_181 * 0.0357142873108386993408203125f;
				fragment_output_0.z = fragment_unnamed_177 * 0.0357142873108386993408203125f;
				fragment_output_0.w = fragment_unnamed_167;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				fragment_uniform_buffer_1[52] = float4(_RTHandleScale[0], _RTHandleScale[1], _RTHandleScale[2], _RTHandleScale[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
		Pass
		{
			Name "Tilt Shift: Composite"
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
			GpuProgramID 303218

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


			ENDHLSL
		}
		Pass
		{
			Name "Tilt Shift: Debug"
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
			GpuProgramID 351068

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
			float _Offset;
			float _Angle;

			static float4 fragment_uniform_buffer_0[6];
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
				float fragment_unnamed_70 = 1.0f / fragment_uniform_buffer_0[4u].y;
				float fragment_unnamed_72 = clamp(fragment_unnamed_70 * (min(abs(mad(clamp(dot(float2(fragment_input_1.x + (-0.5f), fragment_input_1.y + (-0.5f)), float2(sin((-0.0f) - fragment_uniform_buffer_0[5u].y), cos(fragment_uniform_buffer_0[5u].y))) + 0.5f, 0.0f, 1.0f), 2.0f, -1.0f) + ((-0.0f) - fragment_uniform_buffer_0[5u].x)), 1.0f) + ((-0.0f) - fragment_uniform_buffer_0[4u].x)), 0.0f, 1.0f);
				float fragment_unnamed_82 = mad(fragment_input_1.x, 2.0f, -1.0f);
				float fragment_unnamed_83 = mad(fragment_input_1.y, 2.0f, -1.0f);
				float fragment_unnamed_94 = clamp(fragment_unnamed_70 * (sqrt(dot(float2(fragment_unnamed_82, fragment_unnamed_83), float2(fragment_unnamed_82, fragment_unnamed_83))) + ((-0.0f) - fragment_uniform_buffer_0[4u].x)), 0.0f, 1.0f);
				float fragment_unnamed_98 = min((fragment_unnamed_72 * fragment_unnamed_72) * mad(fragment_unnamed_72, -2.0f, 3.0f), 1.0f);
				float fragment_unnamed_99 = min((fragment_unnamed_94 * fragment_unnamed_94) * mad(fragment_unnamed_94, -2.0f, 3.0f), 1.0f);
				bool fragment_unnamed_104 = fragment_uniform_buffer_0[4u].w == 0.0f;
				fragment_output_0.x = fragment_unnamed_104 ? fragment_unnamed_98 : fragment_unnamed_99;
				fragment_output_0.y = fragment_unnamed_104 ? fragment_unnamed_98 : fragment_unnamed_99;
				fragment_output_0.z = fragment_unnamed_104 ? fragment_unnamed_98 : fragment_unnamed_99;
				fragment_output_0.w = fragment_unnamed_104 ? fragment_unnamed_98 : fragment_unnamed_99;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				fragment_uniform_buffer_0[5] = float4(_Offset, fragment_uniform_buffer_0[5][1], fragment_uniform_buffer_0[5][2], fragment_uniform_buffer_0[5][3]);

				fragment_uniform_buffer_0[5] = float4(fragment_uniform_buffer_0[5][0], _Angle, fragment_uniform_buffer_0[5][2], fragment_uniform_buffer_0[5][3]);

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
