Shader "SCPSL/GrayscaleUI"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
		_LeftColor ("LeftColor", Color) = (0,0,0,0)
		_RightColor ("RightColor", Color) = (0,0,0,0)
		_Start ("Start", Float) = 0
	}
	SubShader
	{
		Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass
		{
			Name "Default"
			Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One OneMinusSrcAlpha
			ColorMask [_ColorMask]
			ZTest [unity_GUIZTestMode]
			ZWrite Off
			Cull Off
			Stencil
			{
				Ref [_Stencil]
				ReadMask [_StencilReadMask]
				WriteMask [_StencilWriteMask]
				Comp [_StencilComp]
				Pass [_StencilOp]
				Fail Keep
				ZFail Keep
			}
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 54234

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma multi_compile _ UNITY_UI_ALPHACLIP
			#pragma multi_compile _ UNITY_UI_CLIP_RECT


			#if (!defined(UNITY_UI_ALPHACLIP) && !defined(UNITY_UI_CLIP_RECT)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4 _Color;
			float4 _ClipRect;
			float _UIMaskSoftnessX;
			float _UIMaskSoftnessY;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_4 : TEXCOORD2; // TEXCOORD_2
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
				float vertex_unnamed_136 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_89, vertex_unnamed_103)));
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_89, vertex_unnamed_100)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_89, vertex_unnamed_101)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_89, vertex_unnamed_102)));
				gl_Position.w = vertex_unnamed_136;
				precise float vertex_unnamed_156 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_157 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_158 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_159 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				vertex_output_1.x = vertex_unnamed_156;
				vertex_output_1.y = vertex_unnamed_157;
				vertex_output_1.z = vertex_unnamed_158;
				vertex_output_1.w = vertex_unnamed_159;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
				precise float vertex_unnamed_190 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_191 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_204 = vertex_unnamed_136 / abs(mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_190));
				precise float vertex_unnamed_205 = vertex_unnamed_136 / abs(mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_191));
				precise float vertex_unnamed_215 = 0.25f / mad(vertex_uniform_buffer_0[6u].x, 0.25f, abs(vertex_unnamed_204));
				precise float vertex_unnamed_216 = 0.25f / mad(vertex_uniform_buffer_0[6u].y, 0.25f, abs(vertex_unnamed_205));
				vertex_output_4.z = vertex_unnamed_215;
				vertex_output_4.w = vertex_unnamed_216;
				precise float vertex_unnamed_239 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_241 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_245 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_246 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_247 = vertex_unnamed_245 + mad(vertex_input_0.x, 2.0f, vertex_unnamed_239);
				precise float vertex_unnamed_248 = vertex_unnamed_246 + mad(vertex_input_0.y, 2.0f, vertex_unnamed_241);
				vertex_output_4.x = vertex_unnamed_247;
				vertex_output_4.y = vertex_unnamed_248;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				vertex_uniform_buffer_0[4] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[6] = float4(_UIMaskSoftnessX, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[6] = float4(vertex_uniform_buffer_0[6][0], _UIMaskSoftnessY, vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_3[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_3[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_3[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

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
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}
			#endif
			#if (!defined(UNITY_UI_ALPHACLIP) && !defined(UNITY_UI_CLIP_RECT)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float4 _LeftColor;
			float4 _RightColor;
			float _Start;

			static float4 fragment_uniform_buffer_0[10];
			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_4 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_32 = fragment_input_2.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_43 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_44 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_45 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_46 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].w;
				precise float fragment_unnamed_57 = (-0.0f) - fragment_unnamed_43;
				precise float fragment_unnamed_59 = (-0.0f) - fragment_unnamed_44;
				precise float fragment_unnamed_60 = (-0.0f) - fragment_unnamed_45;
				precise float fragment_unnamed_61 = (-0.0f) - fragment_unnamed_46;
				float fragment_unnamed_70 = mad(fragment_unnamed_32, mad(fragment_uniform_buffer_0[8u].w, fragment_uniform_buffer_0[8u].w, fragment_unnamed_61), fragment_unnamed_46);
				precise float fragment_unnamed_71 = fragment_unnamed_70 * mad(fragment_unnamed_32, mad(fragment_uniform_buffer_0[8u].x, fragment_uniform_buffer_0[8u].w, fragment_unnamed_57), fragment_unnamed_43);
				precise float fragment_unnamed_72 = fragment_unnamed_70 * mad(fragment_unnamed_32, mad(fragment_uniform_buffer_0[8u].y, fragment_uniform_buffer_0[8u].w, fragment_unnamed_59), fragment_unnamed_44);
				precise float fragment_unnamed_73 = fragment_unnamed_70 * mad(fragment_unnamed_32, mad(fragment_uniform_buffer_0[8u].z, fragment_uniform_buffer_0[8u].w, fragment_unnamed_60), fragment_unnamed_45);
				fragment_output_0.x = fragment_unnamed_71;
				fragment_output_0.y = fragment_unnamed_72;
				fragment_output_0.z = fragment_unnamed_73;
				fragment_output_0.w = fragment_unnamed_70;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[7] = float4(_LeftColor[0], _LeftColor[1], _LeftColor[2], _LeftColor[3]);

				fragment_uniform_buffer_0[8] = float4(_RightColor[0], _RightColor[1], _RightColor[2], _RightColor[3]);

				fragment_uniform_buffer_0[9] = float4(_Start, fragment_uniform_buffer_0[9][1], fragment_uniform_buffer_0[9][2], fragment_uniform_buffer_0[9][3]);

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
			#if (defined(UNITY_UI_ALPHACLIP) && !defined(UNITY_UI_CLIP_RECT)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4 _Color;
			float4 _ClipRect;
			float _UIMaskSoftnessX;
			float _UIMaskSoftnessY;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_4 : TEXCOORD2; // TEXCOORD_2
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
				float vertex_unnamed_136 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_89, vertex_unnamed_103)));
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_89, vertex_unnamed_100)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_89, vertex_unnamed_101)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_89, vertex_unnamed_102)));
				gl_Position.w = vertex_unnamed_136;
				precise float vertex_unnamed_156 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_157 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_158 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_159 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				vertex_output_1.x = vertex_unnamed_156;
				vertex_output_1.y = vertex_unnamed_157;
				vertex_output_1.z = vertex_unnamed_158;
				vertex_output_1.w = vertex_unnamed_159;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
				precise float vertex_unnamed_190 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_191 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_204 = vertex_unnamed_136 / abs(mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_190));
				precise float vertex_unnamed_205 = vertex_unnamed_136 / abs(mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_191));
				precise float vertex_unnamed_215 = 0.25f / mad(vertex_uniform_buffer_0[6u].x, 0.25f, abs(vertex_unnamed_204));
				precise float vertex_unnamed_216 = 0.25f / mad(vertex_uniform_buffer_0[6u].y, 0.25f, abs(vertex_unnamed_205));
				vertex_output_4.z = vertex_unnamed_215;
				vertex_output_4.w = vertex_unnamed_216;
				precise float vertex_unnamed_239 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_241 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_245 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_246 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_247 = vertex_unnamed_245 + mad(vertex_input_0.x, 2.0f, vertex_unnamed_239);
				precise float vertex_unnamed_248 = vertex_unnamed_246 + mad(vertex_input_0.y, 2.0f, vertex_unnamed_241);
				vertex_output_4.x = vertex_unnamed_247;
				vertex_output_4.y = vertex_unnamed_248;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				vertex_uniform_buffer_0[4] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[6] = float4(_UIMaskSoftnessX, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[6] = float4(vertex_uniform_buffer_0[6][0], _UIMaskSoftnessY, vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_3[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_3[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_3[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

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
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}
			#endif
			#if (defined(UNITY_UI_ALPHACLIP) && !defined(UNITY_UI_CLIP_RECT)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float4 _LeftColor;
			float4 _RightColor;
			float _Start;

			static float4 fragment_uniform_buffer_0[10];
			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_4 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_92)
			{
				if (fragment_unnamed_92)
				{
					discard_state = true;
				}
			}

			void discard_exit()
			{
				if (discard_state)
				{
					discard;
				}
			}

			void frag_main()
			{
				discard_state = false;
				precise float fragment_unnamed_32 = fragment_input_2.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_43 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_44 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_45 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_46 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].w;
				precise float fragment_unnamed_57 = (-0.0f) - fragment_unnamed_43;
				precise float fragment_unnamed_59 = (-0.0f) - fragment_unnamed_44;
				precise float fragment_unnamed_60 = (-0.0f) - fragment_unnamed_45;
				precise float fragment_unnamed_61 = (-0.0f) - fragment_unnamed_46;
				float fragment_unnamed_70 = mad(fragment_unnamed_32, mad(fragment_uniform_buffer_0[8u].w, fragment_uniform_buffer_0[8u].w, fragment_unnamed_61), fragment_unnamed_46);
				precise float fragment_unnamed_71 = fragment_unnamed_70 + (-0.001000000047497451305389404296875f);
				discard_cond(fragment_unnamed_71 < 0.0f);
				precise float fragment_unnamed_79 = fragment_unnamed_70 * mad(fragment_unnamed_32, mad(fragment_uniform_buffer_0[8u].x, fragment_uniform_buffer_0[8u].w, fragment_unnamed_57), fragment_unnamed_43);
				precise float fragment_unnamed_80 = fragment_unnamed_70 * mad(fragment_unnamed_32, mad(fragment_uniform_buffer_0[8u].y, fragment_uniform_buffer_0[8u].w, fragment_unnamed_59), fragment_unnamed_44);
				precise float fragment_unnamed_81 = fragment_unnamed_70 * mad(fragment_unnamed_32, mad(fragment_uniform_buffer_0[8u].z, fragment_uniform_buffer_0[8u].w, fragment_unnamed_60), fragment_unnamed_45);
				fragment_output_0.x = fragment_unnamed_79;
				fragment_output_0.y = fragment_unnamed_80;
				fragment_output_0.z = fragment_unnamed_81;
				fragment_output_0.w = fragment_unnamed_70;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[7] = float4(_LeftColor[0], _LeftColor[1], _LeftColor[2], _LeftColor[3]);

				fragment_uniform_buffer_0[8] = float4(_RightColor[0], _RightColor[1], _RightColor[2], _RightColor[3]);

				fragment_uniform_buffer_0[9] = float4(_Start, fragment_uniform_buffer_0[9][1], fragment_uniform_buffer_0[9][2], fragment_uniform_buffer_0[9][3]);

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
			#if (defined(UNITY_UI_CLIP_RECT) && !defined(UNITY_UI_ALPHACLIP)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4 _Color;
			float4 _ClipRect;
			float _UIMaskSoftnessX;
			float _UIMaskSoftnessY;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_4 : TEXCOORD2; // TEXCOORD_2
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
				float vertex_unnamed_136 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_89, vertex_unnamed_103)));
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_89, vertex_unnamed_100)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_89, vertex_unnamed_101)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_89, vertex_unnamed_102)));
				gl_Position.w = vertex_unnamed_136;
				precise float vertex_unnamed_156 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_157 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_158 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_159 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				vertex_output_1.x = vertex_unnamed_156;
				vertex_output_1.y = vertex_unnamed_157;
				vertex_output_1.z = vertex_unnamed_158;
				vertex_output_1.w = vertex_unnamed_159;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
				precise float vertex_unnamed_190 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_191 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_204 = vertex_unnamed_136 / abs(mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_190));
				precise float vertex_unnamed_205 = vertex_unnamed_136 / abs(mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_191));
				precise float vertex_unnamed_215 = 0.25f / mad(vertex_uniform_buffer_0[6u].x, 0.25f, abs(vertex_unnamed_204));
				precise float vertex_unnamed_216 = 0.25f / mad(vertex_uniform_buffer_0[6u].y, 0.25f, abs(vertex_unnamed_205));
				vertex_output_4.z = vertex_unnamed_215;
				vertex_output_4.w = vertex_unnamed_216;
				precise float vertex_unnamed_239 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_241 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_245 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_246 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_247 = vertex_unnamed_245 + mad(vertex_input_0.x, 2.0f, vertex_unnamed_239);
				precise float vertex_unnamed_248 = vertex_unnamed_246 + mad(vertex_input_0.y, 2.0f, vertex_unnamed_241);
				vertex_output_4.x = vertex_unnamed_247;
				vertex_output_4.y = vertex_unnamed_248;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				vertex_uniform_buffer_0[4] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[6] = float4(_UIMaskSoftnessX, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[6] = float4(vertex_uniform_buffer_0[6][0], _UIMaskSoftnessY, vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_3[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_3[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_3[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

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
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}
			#endif
			#if (defined(UNITY_UI_CLIP_RECT) && !defined(UNITY_UI_ALPHACLIP)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float4 _ClipRect;

			static float4 fragment_uniform_buffer_0[10];
			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_4 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_29 = (-0.0f) - fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_32 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				precise float fragment_unnamed_37 = fragment_unnamed_29 + fragment_uniform_buffer_0[4u].z;
				precise float fragment_unnamed_38 = fragment_unnamed_32 + fragment_uniform_buffer_0[4u].w;
				precise float fragment_unnamed_44 = (-0.0f) - abs(fragment_input_4.x);
				precise float fragment_unnamed_49 = (-0.0f) - abs(fragment_input_4.y);
				precise float fragment_unnamed_50 = fragment_unnamed_37 + fragment_unnamed_44;
				precise float fragment_unnamed_51 = fragment_unnamed_38 + fragment_unnamed_49;
				precise float fragment_unnamed_58 = fragment_unnamed_50 * fragment_input_4.z;
				precise float fragment_unnamed_59 = fragment_unnamed_51 * fragment_input_4.w;
				precise float fragment_unnamed_64 = clamp(fragment_unnamed_59, 0.0f, 1.0f) * clamp(fragment_unnamed_58, 0.0f, 1.0f);
				precise float fragment_unnamed_71 = fragment_input_2.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_82 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_83 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_84 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_85 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].w;
				precise float fragment_unnamed_96 = (-0.0f) - fragment_unnamed_82;
				precise float fragment_unnamed_97 = (-0.0f) - fragment_unnamed_83;
				precise float fragment_unnamed_98 = (-0.0f) - fragment_unnamed_84;
				precise float fragment_unnamed_99 = (-0.0f) - fragment_unnamed_85;
				precise float fragment_unnamed_108 = fragment_unnamed_64 * mad(fragment_unnamed_71, mad(fragment_uniform_buffer_0[8u].w, fragment_uniform_buffer_0[8u].w, fragment_unnamed_99), fragment_unnamed_85);
				precise float fragment_unnamed_109 = fragment_unnamed_108 * mad(fragment_unnamed_71, mad(fragment_uniform_buffer_0[8u].x, fragment_uniform_buffer_0[8u].w, fragment_unnamed_96), fragment_unnamed_82);
				precise float fragment_unnamed_110 = fragment_unnamed_108 * mad(fragment_unnamed_71, mad(fragment_uniform_buffer_0[8u].y, fragment_uniform_buffer_0[8u].w, fragment_unnamed_97), fragment_unnamed_83);
				precise float fragment_unnamed_111 = fragment_unnamed_108 * mad(fragment_unnamed_71, mad(fragment_uniform_buffer_0[8u].z, fragment_uniform_buffer_0[8u].w, fragment_unnamed_98), fragment_unnamed_84);
				fragment_output_0.x = fragment_unnamed_109;
				fragment_output_0.y = fragment_unnamed_110;
				fragment_output_0.z = fragment_unnamed_111;
				fragment_output_0.w = fragment_unnamed_108;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

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
			#if (defined(UNITY_UI_ALPHACLIP) && defined(UNITY_UI_CLIP_RECT)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4 _Color;
			float4 _ClipRect;
			float _UIMaskSoftnessX;
			float _UIMaskSoftnessY;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_4 : TEXCOORD2; // TEXCOORD_2
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
				float vertex_unnamed_136 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_89, vertex_unnamed_103)));
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_89, vertex_unnamed_100)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_89, vertex_unnamed_101)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_89, vertex_unnamed_102)));
				gl_Position.w = vertex_unnamed_136;
				precise float vertex_unnamed_156 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_157 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_158 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_159 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				vertex_output_1.x = vertex_unnamed_156;
				vertex_output_1.y = vertex_unnamed_157;
				vertex_output_1.z = vertex_unnamed_158;
				vertex_output_1.w = vertex_unnamed_159;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
				precise float vertex_unnamed_190 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_191 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_204 = vertex_unnamed_136 / abs(mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_190));
				precise float vertex_unnamed_205 = vertex_unnamed_136 / abs(mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_191));
				precise float vertex_unnamed_215 = 0.25f / mad(vertex_uniform_buffer_0[6u].x, 0.25f, abs(vertex_unnamed_204));
				precise float vertex_unnamed_216 = 0.25f / mad(vertex_uniform_buffer_0[6u].y, 0.25f, abs(vertex_unnamed_205));
				vertex_output_4.z = vertex_unnamed_215;
				vertex_output_4.w = vertex_unnamed_216;
				precise float vertex_unnamed_239 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_241 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_245 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_246 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_247 = vertex_unnamed_245 + mad(vertex_input_0.x, 2.0f, vertex_unnamed_239);
				precise float vertex_unnamed_248 = vertex_unnamed_246 + mad(vertex_input_0.y, 2.0f, vertex_unnamed_241);
				vertex_output_4.x = vertex_unnamed_247;
				vertex_output_4.y = vertex_unnamed_248;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				vertex_uniform_buffer_0[4] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[6] = float4(_UIMaskSoftnessX, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[6] = float4(vertex_uniform_buffer_0[6][0], _UIMaskSoftnessY, vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_3[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_3[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_3[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

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
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}
			#endif
			#if (defined(UNITY_UI_ALPHACLIP) && defined(UNITY_UI_CLIP_RECT)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float4 _ClipRect;

			static float4 fragment_uniform_buffer_0[10];
			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_4 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_126)
			{
				if (fragment_unnamed_126)
				{
					discard_state = true;
				}
			}

			void discard_exit()
			{
				if (discard_state)
				{
					discard;
				}
			}

			void frag_main()
			{
				discard_state = false;
				precise float fragment_unnamed_29 = (-0.0f) - fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_32 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				precise float fragment_unnamed_37 = fragment_unnamed_29 + fragment_uniform_buffer_0[4u].z;
				precise float fragment_unnamed_38 = fragment_unnamed_32 + fragment_uniform_buffer_0[4u].w;
				precise float fragment_unnamed_44 = (-0.0f) - abs(fragment_input_4.x);
				precise float fragment_unnamed_49 = (-0.0f) - abs(fragment_input_4.y);
				precise float fragment_unnamed_50 = fragment_unnamed_37 + fragment_unnamed_44;
				precise float fragment_unnamed_51 = fragment_unnamed_38 + fragment_unnamed_49;
				precise float fragment_unnamed_58 = fragment_unnamed_50 * fragment_input_4.z;
				precise float fragment_unnamed_59 = fragment_unnamed_51 * fragment_input_4.w;
				precise float fragment_unnamed_64 = clamp(fragment_unnamed_59, 0.0f, 1.0f) * clamp(fragment_unnamed_58, 0.0f, 1.0f);
				precise float fragment_unnamed_71 = fragment_input_2.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_82 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_83 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_84 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_85 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].w;
				precise float fragment_unnamed_96 = (-0.0f) - fragment_unnamed_82;
				precise float fragment_unnamed_97 = (-0.0f) - fragment_unnamed_83;
				precise float fragment_unnamed_98 = (-0.0f) - fragment_unnamed_84;
				precise float fragment_unnamed_99 = (-0.0f) - fragment_unnamed_85;
				float fragment_unnamed_107 = mad(fragment_unnamed_71, mad(fragment_uniform_buffer_0[8u].w, fragment_uniform_buffer_0[8u].w, fragment_unnamed_99), fragment_unnamed_85);
				precise float fragment_unnamed_110 = fragment_unnamed_64 * fragment_unnamed_107;
				precise float fragment_unnamed_111 = fragment_unnamed_110 * mad(fragment_unnamed_71, mad(fragment_uniform_buffer_0[8u].x, fragment_uniform_buffer_0[8u].w, fragment_unnamed_96), fragment_unnamed_82);
				precise float fragment_unnamed_112 = fragment_unnamed_110 * mad(fragment_unnamed_71, mad(fragment_uniform_buffer_0[8u].y, fragment_uniform_buffer_0[8u].w, fragment_unnamed_97), fragment_unnamed_83);
				precise float fragment_unnamed_113 = fragment_unnamed_110 * mad(fragment_unnamed_71, mad(fragment_uniform_buffer_0[8u].z, fragment_uniform_buffer_0[8u].w, fragment_unnamed_98), fragment_unnamed_84);
				fragment_output_0.x = fragment_unnamed_111;
				fragment_output_0.y = fragment_unnamed_112;
				fragment_output_0.z = fragment_unnamed_113;
				fragment_output_0.w = fragment_unnamed_110;
				discard_cond(mad(fragment_unnamed_107, fragment_unnamed_64, -0.001000000047497451305389404296875f) < 0.0f);
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

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

			float4 _Color;
			float4 _ClipRect;
			float _UIMaskSoftnessX;
			float _UIMaskSoftnessY;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float2 vertex_input_2;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

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
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_4 : TEXCOORD2; // TEXCOORD_2
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
				float vertex_unnamed_136 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_89, vertex_unnamed_103)));
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_89, vertex_unnamed_100)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_89, vertex_unnamed_101)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_92, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_91, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_89, vertex_unnamed_102)));
				gl_Position.w = vertex_unnamed_136;
				precise float vertex_unnamed_156 = vertex_input_1.x * vertex_uniform_buffer_0[2u].x;
				precise float vertex_unnamed_157 = vertex_input_1.y * vertex_uniform_buffer_0[2u].y;
				precise float vertex_unnamed_158 = vertex_input_1.z * vertex_uniform_buffer_0[2u].z;
				precise float vertex_unnamed_159 = vertex_input_1.w * vertex_uniform_buffer_0[2u].w;
				vertex_output_1.x = vertex_unnamed_156;
				vertex_output_1.y = vertex_unnamed_157;
				vertex_output_1.z = vertex_unnamed_158;
				vertex_output_1.w = vertex_unnamed_159;
				vertex_output_2.x = vertex_input_2.x;
				vertex_output_2.y = vertex_input_2.y;
				vertex_output_3.x = vertex_input_0.x;
				vertex_output_3.y = vertex_input_0.y;
				vertex_output_3.z = vertex_input_0.z;
				vertex_output_3.w = vertex_input_0.w;
				precise float vertex_unnamed_190 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_191 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_204 = vertex_unnamed_136 / abs(mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_190));
				precise float vertex_unnamed_205 = vertex_unnamed_136 / abs(mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_191));
				precise float vertex_unnamed_215 = 0.25f / mad(vertex_uniform_buffer_0[6u].x, 0.25f, abs(vertex_unnamed_204));
				precise float vertex_unnamed_216 = 0.25f / mad(vertex_uniform_buffer_0[6u].y, 0.25f, abs(vertex_unnamed_205));
				vertex_output_4.z = vertex_unnamed_215;
				vertex_output_4.w = vertex_unnamed_216;
				precise float vertex_unnamed_239 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_241 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_245 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_246 = (-0.0f) - min(max(vertex_uniform_buffer_0[4u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_247 = vertex_unnamed_245 + mad(vertex_input_0.x, 2.0f, vertex_unnamed_239);
				precise float vertex_unnamed_248 = vertex_unnamed_246 + mad(vertex_input_0.y, 2.0f, vertex_unnamed_241);
				vertex_output_4.x = vertex_unnamed_247;
				vertex_output_4.y = vertex_unnamed_248;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				vertex_uniform_buffer_0[4] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[6] = float4(_UIMaskSoftnessX, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[6] = float4(vertex_uniform_buffer_0[6][0], _UIMaskSoftnessY, vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_3[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_3[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_3[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

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
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			#define RIP_HAS_FRAG


			float4 _LeftColor;
			float4 _RightColor;
			float _Start;

			static float4 fragment_uniform_buffer_0[10];
			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_4 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_32 = fragment_input_2.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_43 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_44 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_45 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_46 = fragment_uniform_buffer_0[7u].w * fragment_uniform_buffer_0[7u].w;
				precise float fragment_unnamed_57 = (-0.0f) - fragment_unnamed_43;
				precise float fragment_unnamed_59 = (-0.0f) - fragment_unnamed_44;
				precise float fragment_unnamed_60 = (-0.0f) - fragment_unnamed_45;
				precise float fragment_unnamed_61 = (-0.0f) - fragment_unnamed_46;
				float fragment_unnamed_70 = mad(fragment_unnamed_32, mad(fragment_uniform_buffer_0[8u].w, fragment_uniform_buffer_0[8u].w, fragment_unnamed_61), fragment_unnamed_46);
				precise float fragment_unnamed_71 = fragment_unnamed_70 * mad(fragment_unnamed_32, mad(fragment_uniform_buffer_0[8u].x, fragment_uniform_buffer_0[8u].w, fragment_unnamed_57), fragment_unnamed_43);
				precise float fragment_unnamed_72 = fragment_unnamed_70 * mad(fragment_unnamed_32, mad(fragment_uniform_buffer_0[8u].y, fragment_uniform_buffer_0[8u].w, fragment_unnamed_59), fragment_unnamed_44);
				precise float fragment_unnamed_73 = fragment_unnamed_70 * mad(fragment_unnamed_32, mad(fragment_uniform_buffer_0[8u].z, fragment_uniform_buffer_0[8u].w, fragment_unnamed_60), fragment_unnamed_45);
				fragment_output_0.x = fragment_unnamed_71;
				fragment_output_0.y = fragment_unnamed_72;
				fragment_output_0.z = fragment_unnamed_73;
				fragment_output_0.w = fragment_unnamed_70;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[7] = float4(_LeftColor[0], _LeftColor[1], _LeftColor[2], _LeftColor[3]);

				fragment_uniform_buffer_0[8] = float4(_RightColor[0], _RightColor[1], _RightColor[2], _RightColor[3]);

				fragment_uniform_buffer_0[9] = float4(_Start, fragment_uniform_buffer_0[9][1], fragment_uniform_buffer_0[9][2], fragment_uniform_buffer_0[9][3]);

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
	}
	CustomEditor "ASEMaterialInspector"
}
