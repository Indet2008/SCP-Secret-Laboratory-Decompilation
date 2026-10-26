// Hand-written replacement for the lost "SoundRippleOutline" shader graph:
// an inverted-hull outline used by SCP-939's sound vision.
Shader "Shader Graphs/SoundRippleOutline"
{
	Properties
	{
		_Thickness ("Thickness", Float) = 0.01
		_ColorIntensity ("ColorIntensity", Float) = 2
		[HDR] _Color ("Color", Color) = (1,1,1,1)
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
			Cull Front

			HLSLPROGRAM
			#pragma vertex Vert
			#pragma fragment Frag
			#pragma target 4.5
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

			CBUFFER_START(UnityPerMaterial)
			float _Thickness;
			float _ColorIntensity;
			float4 _Color;
			CBUFFER_END

			struct Attributes
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
			};

			struct Varyings
			{
				float4 positionCS : SV_POSITION;
			};

			Varyings Vert(Attributes input)
			{
				Varyings output;
				float3 positionWS = TransformObjectToWorld(input.positionOS);
				positionWS += TransformObjectToWorldNormal(input.normalOS) * _Thickness;
				output.positionCS = TransformWorldToHClip(positionWS);
				return output;
			}

			float4 Frag(Varyings input) : SV_Target
			{
				return float4(_Color.rgb * _ColorIntensity * GetCurrentExposureMultiplier(), saturate(_Color.a));
			}
			ENDHLSL
		}
	}
	Fallback Off
}
