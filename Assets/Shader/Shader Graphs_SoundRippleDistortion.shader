// Hand-written replacement for the lost "SoundRippleDistortion" shader graph.
// The original refracted the colour pyramid; this version only draws a faint
// animated fresnel shimmer so it never covers the screen.
Shader "Shader Graphs/SoundRippleDistortion"
{
	Properties
	{
		_Distortion ("Distortion", Float) = 0
		_DistortionSpeed ("DistortionSpeed", Float) = 0
	}
	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" "RenderType" = "Transparent" "Queue" = "Transparent" }
		Pass
		{
			Name "ForwardOnly"
			Tags { "LightMode" = "ForwardOnly" }
			Blend SrcAlpha One
			ZWrite Off
			Cull Back

			HLSLPROGRAM
			#pragma vertex Vert
			#pragma fragment Frag
			#pragma target 4.5
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

			CBUFFER_START(UnityPerMaterial)
			float _Distortion;
			float _DistortionSpeed;
			CBUFFER_END

			struct Attributes
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
			};

			struct Varyings
			{
				float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
			};

			Varyings Vert(Attributes input)
			{
				Varyings output;
				output.positionWS = TransformObjectToWorld(input.positionOS);
				output.positionCS = TransformWorldToHClip(output.positionWS);
				output.normalWS = TransformObjectToWorldNormal(input.normalOS);
				return output;
			}

			float4 Frag(Varyings input) : SV_Target
			{
				float3 viewDir = normalize(GetWorldSpaceViewDir(input.positionWS));
				float fresnel = pow(saturate(1.0 - abs(dot(normalize(input.normalWS), viewDir))), 3.0);
				float shimmer = 0.5 + 0.5 * sin(_Time.y * max(_DistortionSpeed, 1.0) + input.positionWS.y * 10.0);
				return float4(1.0.xxx * GetCurrentExposureMultiplier(), fresnel * shimmer * 0.15);
			}
			ENDHLSL
		}
	}
	Fallback Off
}
