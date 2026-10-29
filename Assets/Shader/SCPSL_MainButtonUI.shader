Shader "SCPSL/MainButtonUI"
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
		_GrayscaleIntensity ("GrayscaleIntensity", Float) = 0
		[HideInInspector] _texcoord ("", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		// Hand-written replacement (the decompiled program rendered solid blue): UI sprite whose
		// colour fades to greyscale by _GrayscaleIntensity (driven by OperationalGuide.LerpGrayscale).
		Pass
		{
			Blend One OneMinusSrcAlpha
			ZWrite Off
			ZTest [unity_GUIZTestMode]
			Cull Off
			ColorMask [_ColorMask]
			Stencil
			{
				Ref [_Stencil]
				ReadMask [_StencilReadMask]
				WriteMask [_StencilWriteMask]
				Comp [_StencilComp]
				Pass [_StencilOp]
			}
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_local _ UNITY_UI_CLIP_RECT
			#pragma multi_compile_local _ UNITY_UI_ALPHACLIP
			#include "UnityCG.cginc"
			#include "UnityUI.cginc"

			sampler2D _MainTex;
			fixed4 _Color;
			fixed4 _TextureSampleAdd;
			float4 _ClipRect;
			float _GrayscaleIntensity;

			struct appdata { float4 vertex : POSITION; float4 color : COLOR; float2 uv : TEXCOORD0; };
			struct v2f { float4 pos : SV_POSITION; fixed4 color : COLOR; float2 uv : TEXCOORD0; float4 world : TEXCOORD1; };

			v2f vert(appdata v)
			{
				v2f o;
				o.world = v.vertex;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				o.color = v.color * _Color;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				// Matches the original program: vertex colour is ignored, alpha is always 1 and the
				// greyscale weights are not normalised (sum ~0.5), so greyed images come out darker.
				float4 c = float4(tex2D(_MainTex, i.uv).rgb, 1);
				float g = dot(c.rgb, float3(0.0396819152, 0.4580217898, 0.0060965396));
				c.rgb = lerp(c.rgb, g.xxx, _GrayscaleIntensity);
				#ifdef UNITY_UI_CLIP_RECT
				c *= UnityGet2DClipping(i.world.xy, _ClipRect);
				#endif
				return c;
			}
			ENDCG
		}
	}
}
