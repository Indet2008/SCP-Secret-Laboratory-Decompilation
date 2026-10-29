Shader "Shader Graphs/Water"
{
	Properties
	{
		_Distortion_intesity ("Distortion intesity", Float) = 1
		_Distortion_blur ("Distortion blur", Float) = 0
		_normal_strenght ("normal strenght", Range(0, 0.1)) = 0.01
		[Normal] _Waves ("Waves", 2D) = "bump" {}
	}
	// Clean rewrite: the decompiled Lit Forward program does not compile. Same wave scroll as the original
	// (uv + _Time.y * 0.05, tiled by _Waves_ST); the scrolled normal bends the scene colour behind the surface.
	// two layers of the _Waves normal map scroll against each other and bend the scene colour
	// behind the surface (no tint, as in the original). _Distortion_blur samples a blurrier mip of
	// HDRP's colour pyramid.
	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" "Queue" = "Transparent" "RenderType" = "Transparent" }
		Pass
		{
			Name "ForwardOnly"
			Tags { "LightMode" = "ForwardOnly" }
			Blend One Zero
			ZWrite Off
			ZTest LEqual
			Cull Back

			HLSLPROGRAM
			#pragma vertex Vert
			#pragma fragment Frag
			#pragma target 4.5
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

			TEXTURE2D(_Waves); SAMPLER(sampler_Waves);

			CBUFFER_START(UnityPerMaterial)
			float4 _Waves_ST;
			float4 _Color;
			float _Distortion_intesity;
			float _Distortion_blur;
			float _normal_strenght;
			CBUFFER_END

			struct Attributes { float3 positionOS : POSITION; float2 uv : TEXCOORD0; };
			struct Varyings { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; };

			Varyings Vert(Attributes input)
			{
				Varyings output;
				output.positionCS = TransformWorldToHClip(TransformObjectToWorld(input.positionOS));
				output.uv = input.uv * _Waves_ST.xy + _Waves_ST.zw;
				return output;
			}

			float4 Frag(Varyings input) : SV_Target
			{
				float t = _Time.y;
				float3 n1 = UnpackNormalScale(SAMPLE_TEXTURE2D(_Waves, sampler_Waves, input.uv + (_Time.y * 0.05) * _Waves_ST.xy), 1.0);
				float2 offset = n1.xy * _normal_strenght * _Distortion_intesity;
				float2 screenUv = saturate(input.positionCS.xy * _ScreenSize.zw + offset);
				float3 col = SampleCameraColor(screenUv, _Distortion_blur);
				// The original has no tint: its lit surface is drawn at a fixed 5% opacity over the distorted scene.
				return float4(col, 1);
			}
			ENDHLSL
		}
	}
	Fallback Off
}
