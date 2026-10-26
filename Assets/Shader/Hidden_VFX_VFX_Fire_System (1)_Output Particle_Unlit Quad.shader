// The decompiled VFX Graph output shader did not compile (merged variants).
// Kept as a valid, invisible shader so materials referencing it do not show the pink error shader.
Shader "Hidden/VFX/VFX_Fire/System (1)/Output Particle|Unlit Quad"
{
	Properties
	{
	}
	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" "Queue" = "Transparent" "RenderType" = "Transparent" }
		Pass
		{
			Name "ForwardOnly"
			Tags { "LightMode" = "ForwardOnly" }
			ZWrite Off
			ColorMask 0

			HLSLPROGRAM
			#pragma vertex Vert
			#pragma fragment Frag
			#pragma target 4.5

			float4 Vert(float4 positionOS : POSITION) : SV_POSITION
			{
				return float4(0.0, 0.0, 0.0, 0.0);
			}

			float4 Frag() : SV_Target
			{
				return 0;
			}
			ENDHLSL
		}
	}
	Fallback Off
}