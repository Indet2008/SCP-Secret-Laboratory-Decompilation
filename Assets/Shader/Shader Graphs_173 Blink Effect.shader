// Hand-written replacement for the lost "173 Blink Effect" shader graph:
// an unlit, transparent fresnel glow tinted by _Top_Light.
Shader "Shader Graphs/173 Blink Effect"
{
	Properties
	{
		[HDR] _Top_Light ("Top Light", Color) = (1,0.4539182,0.0235849,1)
		_AlphaRemap ("AlphaRemap", Vector) = (0.02,0.4,0,0)
		_FresnelPow ("FresnelPow", Float) = 4
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
			float4 _Top_Light;
			float4 _AlphaRemap;
			float _FresnelPow;
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
				float fresnel = pow(saturate(1.0 - abs(dot(normalize(input.normalWS), viewDir))), max(_FresnelPow, 0.01));
				float alpha = smoothstep(_AlphaRemap.x, _AlphaRemap.y, fresnel);
				return float4(_Top_Light.rgb * GetCurrentExposureMultiplier(), saturate(alpha * _Top_Light.a));
			}
			ENDHLSL
		}
	}
	Fallback Off
}
