// Rewritten from the decompiled version, whose loose matrix globals were never bound by HDRP
// (every vertex collapsed to the origin, so the viewmodel kept clipping into walls).
// Used by the FPSForeground custom pass: writes far-plane depth wherever the viewmodel covers,
// so the viewmodel's colour pass is never occluded by nearby geometry.
Shader "Hidden/Renderers/ForegroundDepthClear"
{
	Properties
	{
	}
	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" }
		Pass
		{
			Name "FirstPass"
			Tags { "LightMode" = "FirstPass" }
			ColorMask 0
			Cull Off

			HLSLPROGRAM
			#pragma vertex Vert
			#pragma fragment Frag
			#pragma target 4.5
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

			struct Attributes
			{
				float3 positionOS : POSITION;
			};

			struct Varyings
			{
				float4 positionCS : SV_POSITION;
			};

			struct FragOutput
			{
				float4 color : SV_Target0;
				float depth : SV_Depth;
			};

			Varyings Vert(Attributes input)
			{
				Varyings output;
				output.positionCS = TransformWorldToHClip(TransformObjectToWorld(input.positionOS));
				return output;
			}

			FragOutput Frag(Varyings input)
			{
				FragOutput output;
				output.color = 0;
				#if UNITY_REVERSED_Z
				output.depth = 0.0;
				#else
				output.depth = 1.0;
				#endif
				return output;
			}
			ENDHLSL
		}
	}
	Fallback Off
}
