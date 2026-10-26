Shader "Hidden/Renderers/CustomFog"
{
	HLSLINCLUDE

	#pragma vertex Vert
	#pragma target 4.5
	#pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch

	#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/RenderPass/CustomPass/CustomPassCommon.hlsl"

	float4 _CustomFogColor;
	float4 _DistanceParams;

	float4 FullScreenPass(Varyings varyings) : SV_Target
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(varyings);
		float depth = LoadCameraDepth(varyings.positionCS.xy);
		PositionInputs posInput = GetPositionInput(varyings.positionCS.xy, _ScreenSize.zw, depth, UNITY_MATRIX_I_VP, UNITY_MATRIX_V);
		float dist = distance(posInput.positionWS, GetCurrentViewPosition()) - _ProjectionParams.y;

		float startDistance = _DistanceParams.x;
		float endDistance = _DistanceParams.y;
		float range = endDistance - startDistance;
		float visibility = abs(range) > 0.0001 ? saturate((endDistance - dist) / range) : (dist < endDistance ? 1.0 : 0.0);

		if (Linear01Depth(depth, _ZBufferParams) > 0.99)
		{
			visibility = lerp(1.0, visibility, _DistanceParams.w);
		}

		float fog = min(1.0 - visibility, _DistanceParams.z);
		return float4(_CustomFogColor.rgb, fog * fog);
	}

	ENDHLSL

	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" }
		Pass
		{
			Name "Custom Pass 0"
			ZWrite Off
			ZTest Always
			Blend SrcAlpha OneMinusSrcAlpha
			Cull Off

			HLSLPROGRAM
			#pragma fragment FullScreenPass
			ENDHLSL
		}
	}
	Fallback Off
}
