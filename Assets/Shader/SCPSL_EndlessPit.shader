// Rebuilt replacement for the lost "VFX_EndlessPit" shader graph.
// A transparent plane over a pit that fades the geometry behind it into _Base_Color
// based on how far below the plane it is (scene depth difference), giving a bottomless look.
// _Emission (HDR) adds a glow from below, used by the incinerator variant.
Shader "SCPSL/Endless Pit"
{
	Properties
	{
		_Base_Color ("Base Color", Color) = (0.125,0.145,0.16,1)
		_Color ("Color", Color) = (0,0,0,0)
		[HDR] _Emission ("Emission", Color) = (0,0,0,0)
		_DepthMultiplier ("Depth Multiplier", Float) = 0.26
		_Power ("Power", Float) = 0.5
		_FadeDistance ("Fade Distance (near, far)", Vector) = (0,0.2,0,0)
		_EmissionScale ("Emission Scale", Float) = 0.06
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

			CBUFFER_START(UnityPerMaterial)
			float4 _Base_Color;
			float4 _Color;
			float4 _Emission;
			float _DepthMultiplier;
			float _Power;
			float4 _FadeDistance;
			float _EmissionScale;
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
				// Original VFX_EndlessPit graph (decompiled ForwardOnly program):
				// alpha = saturate((sceneEye - fragEye) * _DepthMultiplier)^_Power * saturate((fragEye - fade.x) / (fade.y - fade.x))
				// colour = _Color * _DeExposureMultiplier + _Emission * exposure. _Base_Color is unused by the original.
				float sceneEye = LinearEyeDepth(LoadCameraDepth(uint2(input.positionCS.xy)), _ZBufferParams);
				float fragEye = LinearEyeDepth(input.positionCS.z, _ZBufferParams);
				float depth = pow(saturate((sceneEye - fragEye) * _DepthMultiplier), _Power);
				float nearFade = saturate((fragEye - _FadeDistance.x) / (_FadeDistance.y - _FadeDistance.x));
				float alpha = depth * nearFade;
				float3 col = _Color.rgb * _DeExposureMultiplier + _Emission.rgb * GetCurrentExposureMultiplier();
				return float4(col, alpha);
			}
			ENDHLSL
		}
	}
	Fallback Off
}
