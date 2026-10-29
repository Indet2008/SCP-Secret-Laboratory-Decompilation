Shader "Shader Graphs/NVSight"
{
	Properties
		{
			[NoScaleOffset] _Crosshair ("Crosshair", 2D) = "white" {}
			[HDR] _VisionColor ("VisionColor", Color) = (1,1,1,1)
			_NoiseColor ("NoiseColor", Color) = (0,0.05327413,0.1415094,1)
			[NoScaleOffset] _Filter ("Filter", 2D) = "white" {}
			[NoScaleOffset] _RenderTex ("RenderTex", 2D) = "white" {}
			_Ads ("Ads", Float) = 0
			[HideInInspector] _EmissionColor ("Color", Color) = (1,1,1,1)
			[HideInInspector] _RenderQueueType ("Float", Float) = 1
		}
	// Hand-written replacement for the original NVSight graph (night-vision scope screen).
	// The zoomed view in _RenderTex (from ViewmodelDualCamExtension) is shown in color, tinted by _VisionColor;
	// unaimed the screen shows _NoiseColor static. Masked by _Filter, with _Crosshair on top.
	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" "RenderType" = "Transparent" "Queue" = "Transparent" }
		Pass
		{
			Name "ForwardOnly"
			Tags { "LightMode" = "ForwardOnly" }
			// Drawn in the transparent pass: HDRP opaque forward-only passes need a depth prepass this shader does not have.
			Blend One Zero
			ZWrite On
			Cull Off

			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.5
			#pragma multi_compile_instancing

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

			TEXTURE2D(_RenderTex); SAMPLER(sampler_RenderTex);
			TEXTURE2D(_Crosshair); SAMPLER(sampler_Crosshair);
			TEXTURE2D(_Filter); SAMPLER(sampler_Filter);
			float4 _VisionColor;
			float4 _NoiseColor;
			float _Ads;

			struct Attributes { float4 vertex : POSITION; float2 uv : TEXCOORD0; UNITY_VERTEX_INPUT_INSTANCE_ID };
			struct Varyings { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; UNITY_VERTEX_OUTPUT_STEREO };

			Varyings vert(Attributes v)
			{
				Varyings o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.positionCS = TransformWorldToHClip(TransformObjectToWorld(v.vertex.xyz));
				o.uv = v.uv;
				return o;
			}

			float Hash(float2 p) { return frac(sin(dot(p, float2(12.9898, 78.233))) * 43758.5453); }

			float4 frag(Varyings i) : SV_Target
			{
				float2 uv = i.uv;
				float3 scene = SAMPLE_TEXTURE2D(_RenderTex, sampler_RenderTex, uv).rgb;
				// The scope camera output is already exposed: show it in color, tinted by _VisionColor.
				float noise = Hash(floor(uv * 256) + frac(_Time.y * 23.0) * 100.0);
				float3 idle = _NoiseColor.rgb * (0.6 + 0.4 * noise);
				// The scope camera only renders while aiming, so the image fades in with _Ads; unaimed the screen shows static.
				float3 col = lerp(idle, scene * _VisionColor.rgb, saturate(_Ads));
				col *= SAMPLE_TEXTURE2D(_Filter, sampler_Filter, uv).rgb;
				float4 ch = SAMPLE_TEXTURE2D(_Crosshair, sampler_Crosshair, uv);
				col = lerp(col, ch.rgb, ch.a * saturate(_Ads));
				return float4(col, 1);
			}
			ENDHLSL
		}
	}
}
