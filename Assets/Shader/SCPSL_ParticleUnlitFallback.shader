// Unlit HDRP particle shader used by the VFX Graph replacements (VfxParticleFallback).
// Texture * tint * particle vertex colour; flipbook UVs come from the Particle System itself.
// Blend mode is chosen per material: additive (_SrcBlend=SrcAlpha, _DstBlend=One)
// or alpha blended (_SrcBlend=SrcAlpha, _DstBlend=OneMinusSrcAlpha).
Shader "SCPSL/Particle Unlit Fallback"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		[HDR] _Color ("Tint", Color) = (1,1,1,1)
		_Intensity ("Intensity", Float) = 1
		[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("Src Blend", Float) = 5
		[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("Dst Blend", Float) = 10
	}
	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" "Queue" = "Transparent" "RenderType" = "Transparent" "IgnoreProjector" = "True" }
		Pass
		{
			Name "ForwardOnly"
			Tags { "LightMode" = "ForwardOnly" }
			Blend [_SrcBlend] [_DstBlend]
			ZWrite Off
			Cull Off

			HLSLPROGRAM
			#pragma vertex Vert
			#pragma fragment Frag
			#pragma target 4.5
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

			TEXTURE2D(_MainTex);
			SAMPLER(sampler_MainTex);

			CBUFFER_START(UnityPerMaterial)
			float4 _MainTex_ST;
			float4 _Color;
			float _Intensity;
			float _SrcBlend;
			float _DstBlend;
			CBUFFER_END

			struct Attributes
			{
				float3 positionOS : POSITION;
				float4 color : COLOR;
				float2 uv : TEXCOORD0;
			};

			struct Varyings
			{
				float4 positionCS : SV_POSITION;
				float4 color : COLOR;
				float2 uv : TEXCOORD0;
			};

			Varyings Vert(Attributes input)
			{
				Varyings output;
				output.positionCS = TransformWorldToHClip(TransformObjectToWorld(input.positionOS));
				output.color = input.color;
				output.uv = input.uv * _MainTex_ST.xy + _MainTex_ST.zw;
				return output;
			}

			float4 Frag(Varyings input) : SV_Target
			{
				float4 col = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv) * _Color * input.color;
				col.rgb *= _Intensity * GetCurrentExposureMultiplier();
				return col;
			}
			ENDHLSL
		}
	}
	Fallback Off
}
