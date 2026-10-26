// Rebuilt replacement for the lost "VFX_EndlessPit" shader graph.
// A transparent plane over a pit that fades the geometry behind it into _Base_Color
// based on how far below the plane it is (scene depth difference), giving a bottomless look.
// _Emission (HDR) adds a glow from below, used by the incinerator variant.
Shader "SCPSL/Endless Pit"
{
	Properties
	{
		_Base_Color ("Base Color", Color) = (0.125,0.145,0.16,1)
		[HDR] _Emission ("Emission", Color) = (0,0,0,0)
		_DepthMultiplier ("Depth Multiplier", Float) = 0.26
		_Power ("Power", Float) = 0.5
		_FadeDistance ("Fade Distance (near, far)", Vector) = (0,0.2,0,0)
		_EmissionScale ("Emission Scale", Float) = 0.02
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
			float4 _Emission;
			float _DepthMultiplier;
			float _Power;
			float4 _FadeDistance;
			float _EmissionScale;
			CBUFFER_END

			struct Attributes { float3 positionOS : POSITION; };
			struct Varyings { float4 positionCS : SV_POSITION; };

			Varyings Vert(Attributes input)
			{
				Varyings output;
				output.positionCS = TransformWorldToHClip(TransformObjectToWorld(input.positionOS));
				return output;
			}

			float4 Frag(Varyings input) : SV_Target
			{
				float sceneEye = LinearEyeDepth(LoadCameraDepth(uint2(input.positionCS.xy)), _ZBufferParams);
				float surfaceEye = LinearEyeDepth(input.positionCS.z, _ZBufferParams);
				float behind = max(0.0, sceneEye - surfaceEye);
				float fade = saturate(pow(saturate(behind * _DepthMultiplier), max(_Power, 0.01)));
				// Soften the edge where the plane meets nearby geometry.
				float edge = saturate((behind - _FadeDistance.x) / max(_FadeDistance.y - _FadeDistance.x, 0.001));
				float alpha = saturate(fade * edge * _Base_Color.a);
				float3 col = _Base_Color.rgb + _Emission.rgb * _EmissionScale * fade;
				return float4(col * GetCurrentExposureMultiplier(), alpha);
			}
			ENDHLSL
		}
	}
	Fallback Off
}
