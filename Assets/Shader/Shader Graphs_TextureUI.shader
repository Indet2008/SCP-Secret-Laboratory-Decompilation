// Hand-written replacement for the original "Shader Graphs/TextureUI" graph (HDRP unlit, transparent).
// The decompiled program was unusable, and the UI/Default fallback projects with the legacy camera matrices,
// so world-space screens on viewmodels (radio, Chaos access device, Micro-HID) were drawn with the main
// camera's FOV instead of the viewmodel camera's. This version uses HDRP's camera constants, which
// FPSForeground's OverrideCameraRendering swaps to the viewmodel camera.
Shader "Shader Graphs/TextureUI"
{
	Properties
		{
			[NoScaleOffset] _MainTex ("MainTex", 2D) = "white" {}
			_Color ("Tint", Color) = (1,1,1,1)

			// uGUI masking / stencil (set by Mask components on their material copies)
			[HideInInspector] _StencilComp ("Stencil Comparison", Float) = 8
			[HideInInspector] _Stencil ("Stencil ID", Float) = 0
			[HideInInspector] _StencilOp ("Stencil Operation", Float) = 0
			[HideInInspector] _StencilWriteMask ("Stencil Write Mask", Float) = 255
			[HideInInspector] _StencilReadMask ("Stencil Read Mask", Float) = 255
			[HideInInspector] _ColorMask ("Color Mask", Float) = 15
			[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0

			// Serialized HDRP surface options from the original graph (kept so existing materials load unchanged)
			[HideInInspector] _EmissionColor ("Color", Color) = (1,1,1,1)
			[HideInInspector] _RenderQueueType ("Float", Float) = 4
			[HideInInspector] _SurfaceType ("Float", Float) = 1
			[HideInInspector] _BlendMode ("Float", Float) = 0
			[HideInInspector] _SrcBlend ("Float", Float) = 1
			[HideInInspector] _DstBlend ("Float", Float) = 10
			[HideInInspector] _AlphaSrcBlend ("Float", Float) = 1
			[HideInInspector] _AlphaDstBlend ("Float", Float) = 10
			[ToggleUI] [HideInInspector] _ZWrite ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _TransparentZWrite ("Boolean", Float) = 0
			[HideInInspector] _CullMode ("Float", Float) = 2
			[ToggleUI] [HideInInspector] _EnableFogOnTransparent ("Boolean", Float) = 1
			[Enum(UnityEngine.Rendering.CompareFunction)] [HideInInspector] _ZTestTransparent ("Float", Float) = 4
		}
	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
			"PreviewType" = "Plane"
			"CanUseSpriteAtlas" = "True"
			"RenderPipeline" = "HDRenderPipeline"
		}

		Stencil
		{
			Ref [_Stencil]
			Comp [_StencilComp]
			Pass [_StencilOp]
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
		}

		Cull Off
		ZWrite Off
		ZTest [unity_GUIZTestMode]
		Blend One OneMinusSrcAlpha
		ColorMask [_ColorMask]

		Pass
		{
			Name "Default"

			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.5
			#pragma multi_compile_instancing
			#pragma multi_compile_local _ UNITY_UI_CLIP_RECT
			#pragma multi_compile_local _ UNITY_UI_ALPHACLIP

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

			TEXTURE2D(_MainTex);
			SAMPLER(sampler_MainTex);

			float4 _Color;
			float4 _TextureSampleAdd;
			float4 _ClipRect;

			struct Attributes
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct Varyings
			{
				float4 positionCS : SV_POSITION;
				float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
				float4 localPosition : TEXCOORD1;
				UNITY_VERTEX_OUTPUT_STEREO
			};

			Varyings vert(Attributes v)
			{
				Varyings o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				float3 positionWS = TransformObjectToWorld(v.vertex.xyz);
				o.positionCS = TransformWorldToHClip(positionWS);
				o.localPosition = v.vertex;
				o.texcoord = v.texcoord;
				o.color = v.color * _Color;
				return o;
			}

			float4 frag(Varyings i) : SV_Target
			{
				float4 color = (SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoord) + _TextureSampleAdd) * i.color;

				#ifdef UNITY_UI_CLIP_RECT
				float2 inside = step(_ClipRect.xy, i.localPosition.xy) * step(i.localPosition.xy, _ClipRect.zw);
				color.a *= inside.x * inside.y;
				#endif

				#ifdef UNITY_UI_ALPHACLIP
				clip(color.a - 0.001);
				#endif

				color.rgb *= color.a;
				return color;
			}
			ENDHLSL
		}
	}
	Fallback "UI/Default"
}
