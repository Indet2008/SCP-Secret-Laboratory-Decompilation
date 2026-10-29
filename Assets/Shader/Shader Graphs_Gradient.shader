// Rebuilt "Shader Graphs/Gradient" (UI canvas graph; the material was bound to a stock sample graph and drew solid white).
// Horizontal gradient from _LeftColor to _RightColor across the UI rect (rotated by _Rotation degrees),
// each side scaled by its colour/alpha modifier and multiplied by the Graphic's vertex colour.
Shader "Shader Graphs/Gradient"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_LeftColor ("LeftColor", Color) = (0,0,0,0)
		_RightColor ("RightColor", Color) = (1,1,1,1)
		_Rotation ("Rotation", Float) = 0
		_LeftColorModifier ("LeftColorModifier", Float) = 1
		_RightColorModifier ("RightColorModifier", Float) = 1
		_LeftAlphaModifier ("LeftAlphaModifier", Float) = 1
		_RightAlphaModifier ("RightAlphaModifier", Float) = 1
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
	}
	SubShader
	{
		Tags { "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" "PreviewType" = "Plane" "CanUseSpriteAtlas" = "True" }
		Stencil
		{
			Ref [_Stencil]
			Comp [_StencilComp]
			Pass [_StencilOp]
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
		}
		Cull Off
		Lighting Off
		ZWrite Off
		ZTest [unity_GUIZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask [_ColorMask]

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_local _ UNITY_UI_CLIP_RECT
			#include "UnityCG.cginc"
			#include "UnityUI.cginc"

			fixed4 _LeftColor;
			fixed4 _RightColor;
			float _Rotation;
			float _LeftColorModifier;
			float _RightColorModifier;
			float _LeftAlphaModifier;
			float _RightAlphaModifier;
			float4 _ClipRect;

			struct appdata { float4 vertex : POSITION; float4 color : COLOR; float2 uv : TEXCOORD0; };
			struct v2f { float4 pos : SV_POSITION; fixed4 color : COLOR; float2 uv : TEXCOORD0; float4 world : TEXCOORD1; };

			v2f vert(appdata v)
			{
				v2f o;
				o.world = v.vertex;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				o.color = v.color;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				float r = radians(_Rotation);
				float2 c = i.uv - 0.5;
				float t = saturate(c.x * cos(r) - c.y * sin(r) + 0.5);
				float3 rgb = lerp(_LeftColor.rgb * _LeftColorModifier, _RightColor.rgb * _RightColorModifier, t);
				float a = lerp(_LeftColor.a * _LeftAlphaModifier, _RightColor.a * _RightAlphaModifier, t);
				fixed4 col = fixed4(rgb, a) * i.color;
				#ifdef UNITY_UI_CLIP_RECT
				col.a *= UnityGet2DClipping(i.world.xy, _ClipRect);
				#endif
				return col;
			}
			ENDCG
		}
	}
}
