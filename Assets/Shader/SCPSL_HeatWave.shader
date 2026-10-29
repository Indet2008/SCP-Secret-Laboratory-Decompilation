// Rebuilt replacement for the lost "VFX_HeatWave_Fresnel" shader graph (HCZ incinerator).
// Draws nothing itself: it refracts the scene color behind it with rising noise, faded out by a fresnel mask
// so the mesh silhouette is invisible. Property names match the original material.
Shader "SCPSL/HeatWave"
{
	Properties
	{
		_Distortion_text ("Distortion Texture", 2D) = "gray" {}
		_Distortion_text_tiling ("Distortion Tiling", Vector) = (1,1,0,0)
		_Distortion_Speed ("Distortion Speed", Vector) = (0,0,0,0)
		_Distortion_Intensity ("Distortion Intensity", Float) = 10
		_Fresnel_Power ("Fresnel Power", Float) = 1.5
		_Darken ("Darken", Range(0,1)) = 0
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

			TEXTURE2D(_Distortion_text); SAMPLER(sampler_Distortion_text);

			CBUFFER_START(UnityPerMaterial)
			float4 _Distortion_text_ST;
			float4 _Distortion_text_tiling;
			float4 _Distortion_Speed;
			float _Distortion_Intensity;
			float _Fresnel_Power;
			float _Darken;
			CBUFFER_END

			struct Attributes { float3 positionOS : POSITION; float3 normalOS : NORMAL; float2 uv : TEXCOORD0; };
			struct Varyings { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; float3 normalWS : TEXCOORD1; float3 positionWS : TEXCOORD2; };

			Varyings Vert(Attributes input)
			{
				Varyings output;
				output.positionWS = TransformObjectToWorld(input.positionOS);
				output.positionCS = TransformWorldToHClip(output.positionWS);
				output.normalWS = TransformObjectToWorldNormal(input.normalOS);
				output.uv = input.uv;
				return output;
			}

			float4 Frag(Varyings input) : SV_Target
			{
				float t = _Time.y;
				// Heat rises: fall back to an upward scroll when the material leaves the speed at zero.
				float2 speed = any(_Distortion_Speed.xy) ? _Distortion_Speed.xy : float2(0.05, -0.35);
				float2 uv = input.uv * _Distortion_text_tiling.xy;
				float n1 = SAMPLE_TEXTURE2D(_Distortion_text, sampler_Distortion_text, uv * 3.0 + speed * t).r;
				float n2 = SAMPLE_TEXTURE2D(_Distortion_text, sampler_Distortion_text, uv * 5.0 + speed * float2(-0.7, 1.3) * t).r;
				float2 offset = float2(n1 - 0.5, n2 - 0.5);

				// Strongest where the surface faces the camera, gone at the silhouette.
				float3 viewDir = GetWorldSpaceNormalizeViewDir(input.positionWS);
				float facing = saturate(abs(dot(normalize(input.normalWS), viewDir)));
				float mask = pow(facing, _Fresnel_Power);

				float2 screenUv = input.positionCS.xy * _ScreenSize.zw;
				float2 distortedUv = saturate(screenUv + offset * _Distortion_Intensity * 0.0006 * mask);
				float3 col = SampleCameraColor(distortedUv);
				col *= 1.0 - _Darken * mask * saturate(n1 * n2 * 4.0);
				return float4(col, mask);
			}
			ENDHLSL
		}
	}
	Fallback Off
}
