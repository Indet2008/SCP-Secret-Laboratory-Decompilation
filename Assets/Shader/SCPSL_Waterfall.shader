// Rebuilt replacement for the lost "Waterfall Material" shader graph (HCZ water room).
// Two scrolling layers of a noise texture, UV-warped by a third, form the falling streaks.
// Property names match the original material so its saved values are reused.
Shader "SCPSL/Waterfall"
{
	Properties
	{
		_Base_text ("Base Texture", 2D) = "white" {}
		_Distortion_text ("Distortion Texture", 2D) = "gray" {}
		_BaseColor ("Color", Color) = (1,1,1,1)
		_Base_text_tiling ("Base Tiling", Vector) = (25,2.2,0,0)
		_Distortion_text_tiling ("Distortion Tiling", Vector) = (22.6,6.85,0,0)
		_Speed ("Layer 1 Speed", Vector) = (0.1,0.1,0,0)
		_Speed_2 ("Layer 2 Speed", Vector) = (-0.1,0.2,0,0)
		_Distort_Speed ("Distortion Speed", Vector) = (1,0,0,0)
		_Distortion_Intensity ("Distortion Intensity", Float) = -0.02
		_Brightness ("Brightness", Float) = 0.12
		_Opacity ("Opacity", Range(0,1)) = 0.97
	}
	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" "Queue" = "Transparent" "RenderType" = "Transparent" }
		Pass
		{
			Name "ForwardOnly"
			Tags { "LightMode" = "ForwardOnly" }
			Blend SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off

			HLSLPROGRAM
			#pragma vertex Vert
			#pragma fragment Frag
			#pragma target 4.5
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

			TEXTURE2D(_Base_text); SAMPLER(sampler_Base_text);
			TEXTURE2D(_Distortion_text); SAMPLER(sampler_Distortion_text);

			CBUFFER_START(UnityPerMaterial)
			float4 _BaseColor;
			float4 _Base_text_tiling;
			float4 _Distortion_text_tiling;
			float4 _Speed;
			float4 _Speed_2;
			float4 _Distort_Speed;
			float _Distortion_Intensity;
			float _Brightness;
			float _Opacity;
			CBUFFER_END

			struct Attributes { float3 positionOS : POSITION; float2 uv : TEXCOORD0; };
			struct Varyings { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; };

			Varyings Vert(Attributes input)
			{
				Varyings output;
				output.positionCS = TransformWorldToHClip(TransformObjectToWorld(input.positionOS));
				output.uv = input.uv;
				return output;
			}

			float4 Frag(Varyings input) : SV_Target
			{
				float t = _Time.y;
				float2 distUv = input.uv * _Distortion_text_tiling.xy + _Distort_Speed.xy * t * 0.1;
				// Gentle warp only: the original reads as a smooth heavy sheet, not boiling noise.
				float2 warp = (SAMPLE_TEXTURE2D(_Distortion_text, sampler_Distortion_text, distUv).rg - 0.5) * _Distortion_Intensity;
				// Stretch the noise vertically into long thin streaks instead of blotches.
				float2 tiling = float2(_Base_text_tiling.x, _Base_text_tiling.y * 0.25);
				// Both layers scroll straight down (no sideways drift) at different rates.
				float2 uv1 = input.uv * tiling + float2(0, abs(_Speed.y) * 4.0 * t) + warp;
				float2 uv2 = input.uv * tiling * float2(1.3, 0.8) + float2(0, abs(_Speed_2.y) * 3.0 * t) - warp;
				float n1 = SAMPLE_TEXTURE2D(_Base_text, sampler_Base_text, uv1).r;
				float n2 = SAMPLE_TEXTURE2D(_Base_text, sampler_Base_text, uv2).r;
				float streaks = saturate((n1 + n2) * 0.5);
				// Dense thin vertical folds of the falling sheet, slightly wobbling as it flows.
				float folds = 0.5 + 0.5 * sin(input.uv.x * _Base_text_tiling.x * 25.13 + warp.x * 10.0);
				folds *= folds;
				float shade = 0.45 + streaks * 0.35 + folds * 0.25;
				float3 col = _BaseColor.rgb * shade * _Brightness;
				float alpha = saturate(_Opacity * _BaseColor.a);
				return float4(col * GetCurrentExposureMultiplier(), alpha);
			}
			ENDHLSL
		}
	}
	Fallback Off
}
