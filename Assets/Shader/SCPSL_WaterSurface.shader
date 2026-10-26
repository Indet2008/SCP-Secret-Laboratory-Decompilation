// Rebuilt replacement for the lost "VFX_Water" shader graph (HCZ water room surface).
// Two caustic noise layers moving in different directions, warped by a second noise.
Shader "SCPSL/Water Surface"
{
	Properties
	{
		_SampleTexture2D_58bd10d2cd3f4a81acb1d40f70b73f5c_Texture_1_Texture2D ("Caustics", 2D) = "white" {}
		_SampleTexture2D_cd0baaeff2bc49b98f6bf404a9f8d89c_Texture_1_Texture2D ("Distortion Noise", 2D) = "gray" {}
		_BaseColor ("Color", Color) = (1,1,1,1)
		_DeepColor ("Deep Color", Color) = (0.05,0.09,0.1,1)
		_Speed ("Layer 1 Speed", Vector) = (0.2,0.21,0,0)
		_Speed_2 ("Layer 2 Speed", Vector) = (-0.2,0.2,0,0)
		_speed ("Distortion Speed", Vector) = (0.4,0.45,0,0)
		_Distort_Intensity ("Distortion Intensity", Float) = 0.02
		_Tiling ("Tiling", Float) = 1
		_Brightness ("Brightness", Float) = 0.3
		_Opacity ("Opacity", Range(0,1)) = 0.8
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
			Cull Back

			HLSLPROGRAM
			#pragma vertex Vert
			#pragma fragment Frag
			#pragma target 4.5
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

			TEXTURE2D(_SampleTexture2D_58bd10d2cd3f4a81acb1d40f70b73f5c_Texture_1_Texture2D); SAMPLER(sampler_SampleTexture2D_58bd10d2cd3f4a81acb1d40f70b73f5c_Texture_1_Texture2D);
			TEXTURE2D(_SampleTexture2D_cd0baaeff2bc49b98f6bf404a9f8d89c_Texture_1_Texture2D); SAMPLER(sampler_SampleTexture2D_cd0baaeff2bc49b98f6bf404a9f8d89c_Texture_1_Texture2D);
			#define _Caustics _SampleTexture2D_58bd10d2cd3f4a81acb1d40f70b73f5c_Texture_1_Texture2D
			#define sampler_Caustics sampler_SampleTexture2D_58bd10d2cd3f4a81acb1d40f70b73f5c_Texture_1_Texture2D
			#define _Noise _SampleTexture2D_cd0baaeff2bc49b98f6bf404a9f8d89c_Texture_1_Texture2D
			#define sampler_Noise sampler_SampleTexture2D_cd0baaeff2bc49b98f6bf404a9f8d89c_Texture_1_Texture2D

			CBUFFER_START(UnityPerMaterial)
			float4 _BaseColor;
			float4 _DeepColor;
			float4 _Speed;
			float4 _Speed_2;
			float4 _speed;
			float _Distort_Intensity;
			float _Tiling;
			float _Brightness;
			float _Opacity;
			CBUFFER_END

			struct Attributes { float3 positionOS : POSITION; float2 uv : TEXCOORD0; };
			struct Varyings { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; };

			Varyings Vert(Attributes input)
			{
				Varyings output;
				output.positionCS = TransformWorldToHClip(TransformObjectToWorld(input.positionOS));
				output.uv = input.uv * _Tiling;
				return output;
			}

			float4 Frag(Varyings input) : SV_Target
			{
				float t = _Time.y;
				float2 warp = (SAMPLE_TEXTURE2D(_Noise, sampler_Noise, input.uv + _speed.xy * t * 0.1).rg - 0.5) * _Distort_Intensity * 10.0;
				float c1 = SAMPLE_TEXTURE2D(_Caustics, sampler_Caustics, input.uv + _Speed.xy * t * 0.1 + warp).r;
				float c2 = SAMPLE_TEXTURE2D(_Caustics, sampler_Caustics, input.uv * 1.3 + _Speed_2.xy * t * 0.1 - warp).r;
				float caustic = saturate(min(c1, c2) * 2.0);
				float3 col = lerp(_DeepColor.rgb, _BaseColor.rgb, caustic) * _Brightness;
				return float4(col * GetCurrentExposureMultiplier(), saturate(_Opacity * _BaseColor.a));
			}
			ENDHLSL
		}
	}
	Fallback Off
}
