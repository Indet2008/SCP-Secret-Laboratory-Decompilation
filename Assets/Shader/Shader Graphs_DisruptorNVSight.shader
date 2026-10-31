Shader "Shader Graphs/DisruptorNVSight"
{
	Properties
		{
			[NoScaleOffset] _Crosshair ("Crosshair", 2D) = "white" {}
			[HDR] _VisionColor ("VisionColor", Color) = (1,1,1,1)
			_NoiseColor ("NoiseColor", Color) = (0,0.05327413,0.1415094,1)
			[NoScaleOffset] _Filter ("Filter", 2D) = "white" {}
			[NoScaleOffset] _RenderTex ("RenderTex", 2D) = "white" {}
			_Ads ("Ads", Float) = 0
			[NoScaleOffset] _OverlayTexture ("OverlayTexture", 2D) = "black" {}
			[HideInInspector] _EmissionColor ("Color", Color) = (1,1,1,1)
			[HideInInspector] _RenderQueueType ("Float", Float) = 1
			[ToggleUI] [HideInInspector] _AddPrecomputedVelocity ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _DepthOffsetEnable ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _ConservativeDepthOffsetEnable ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _TransparentWritingMotionVec ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _AlphaCutoffEnable ("Boolean", Float) = 0
			[HideInInspector] _TransparentSortPriority ("_TransparentSortPriority", Float) = 0
			[ToggleUI] [HideInInspector] _UseShadowThreshold ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _DoubleSidedEnable ("Boolean", Float) = 0
			[Enum(Flip, 0, Mirror, 1, None, 2)] [HideInInspector] _DoubleSidedNormalMode ("Float", Float) = 2
			[HideInInspector] _DoubleSidedConstants ("Vector4", Vector) = (1,1,-1,0)
			[Enum(Auto, 0, On, 1, Off, 2)] [HideInInspector] _DoubleSidedGIMode ("Float", Float) = 0
			[ToggleUI] [HideInInspector] _TransparentDepthPrepassEnable ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _TransparentDepthPostpassEnable ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _PerPixelSorting ("Boolean", Float) = 0
			[HideInInspector] _SurfaceType ("Float", Float) = 0
			[HideInInspector] _BlendMode ("Float", Float) = 0
			[HideInInspector] _SrcBlend ("Float", Float) = 1
			[HideInInspector] _DstBlend ("Float", Float) = 0
			[HideInInspector] _DstBlend2 ("Float", Float) = 0
			[HideInInspector] _AlphaSrcBlend ("Float", Float) = 1
			[HideInInspector] _AlphaDstBlend ("Float", Float) = 0
			[ToggleUI] [HideInInspector] _ZWrite ("Boolean", Float) = 1
			[ToggleUI] [HideInInspector] _TransparentZWrite ("Boolean", Float) = 0
			[HideInInspector] _CullMode ("Float", Float) = 2
			[ToggleUI] [HideInInspector] _EnableFogOnTransparent ("Boolean", Float) = 1
			[HideInInspector] _CullModeForward ("Float", Float) = 2
			[Enum(Front, 1, Back, 2)] [HideInInspector] _TransparentCullMode ("Float", Float) = 2
			[Enum(UnityEngine.Rendering.HighDefinition.OpaqueCullMode)] [HideInInspector] _OpaqueCullMode ("Float", Float) = 2
			[HideInInspector] _ZTestDepthEqualForOpaque ("Float", Float) = 3
			[Enum(UnityEngine.Rendering.CompareFunction)] [HideInInspector] _ZTestTransparent ("Float", Float) = 4
			[ToggleUI] [HideInInspector] _TransparentBackfaceEnable ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _EnableBlendModePreserveSpecularLighting ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _ExcludeFromTUAndAA ("Boolean", Float) = 0
			[HideInInspector] _StencilRef ("Float", Float) = 0
			[HideInInspector] _StencilWriteMask ("Float", Float) = 6
			[HideInInspector] _StencilRefDepth ("Float", Float) = 1
			[HideInInspector] _StencilWriteMaskDepth ("Float", Float) = 9
			[HideInInspector] _StencilRefMV ("Float", Float) = 33
			[HideInInspector] _StencilWriteMaskMV ("Float", Float) = 43
			[HideInInspector] _StencilRefDistortionVec ("Float", Float) = 4
			[HideInInspector] _StencilWriteMaskDistortionVec ("Float", Float) = 4
			[HideInInspector] [NoScaleOffset] unity_Lightmaps ("unity_Lightmaps", 2DArray) = "" {}
			[HideInInspector] [NoScaleOffset] unity_LightmapsInd ("unity_LightmapsInd", 2DArray) = "" {}
			[HideInInspector] [NoScaleOffset] unity_ShadowMasks ("unity_ShadowMasks", 2DArray) = "" {}
		}
	// Hand-written replacement for the original DisruptorNVSight graph: NVSight plus the firing-mode/ammo icons
	// rendered by the "NV Overlay Cam" into _OverlayTexture (black clear), added on top whether aiming or not.
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
			TEXTURE2D(_OverlayTexture); SAMPLER(sampler_OverlayTexture);
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
				col += SAMPLE_TEXTURE2D(_OverlayTexture, sampler_OverlayTexture, uv).rgb;
				return float4(col, 1);
			}
			ENDHLSL
		}
	}
}
