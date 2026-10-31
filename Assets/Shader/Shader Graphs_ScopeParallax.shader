Shader "Shader Graphs/ScopeParallax"
{
	Properties
	{
		[NoScaleOffset] _RenderTex ("RenderTex", 2D) = "white" {}
		[NoScaleOffset] _Crosshair ("Crosshair", 2D) = "white" {}
		_DistanceParallax ("DistanceParallax", Float) = 0
		_OffsetParallax ("OffsetParallax", Float) = 0
		_Ads ("Ads", Float) = 0
		[NoScaleOffset] _SampleTexture2D_ddb5d4c0b06f43db9a156cab155c58c9_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[HideInInspector] _EmissionColor ("Color", Color) = (1,1,1,1)
		[HideInInspector] _RenderQueueType ("Float", Float) = 4
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
		[HideInInspector] _SurfaceType ("Float", Float) = 1
		[HideInInspector] _BlendMode ("Float", Float) = 0
		[HideInInspector] _SrcBlend ("Float", Float) = 1
		[HideInInspector] _DstBlend ("Float", Float) = 0
		[HideInInspector] _DstBlend2 ("Float", Float) = 0
		[HideInInspector] _AlphaSrcBlend ("Float", Float) = 1
		[HideInInspector] _AlphaDstBlend ("Float", Float) = 0
		[ToggleUI] [HideInInspector] _ZWrite ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _TransparentZWrite ("Boolean", Float) = 0
		[HideInInspector] _CullMode ("Float", Float) = 2
		[ToggleUI] [HideInInspector] _EnableFogOnTransparent ("Boolean", Float) = 0
		[HideInInspector] _CullModeForward ("Float", Float) = 2
		[Enum(Front, 1, Back, 2)] [HideInInspector] _TransparentCullMode ("Float", Float) = 2
		[Enum(UnityEngine.Rendering.HighDefinition.OpaqueCullMode)] [HideInInspector] _OpaqueCullMode ("Float", Float) = 2
		[HideInInspector] _ZTestDepthEqualForOpaque ("Float", Float) = 4
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
	// Hand-written replacement for the ScopeParallax graph (scope lens). The decompiled program never drew the lens
	// (the material stayed invisible even with a solid-colour test). Kept from the decompiled math: the reticle is cut out
	// with (1 - crosshair alpha) and the scope image is masked by the "Texture2D" vignette, whose UVs shift with the eye
	// (DistanceParallax / OffsetParallax) and settle on the centre as _Ads reaches 1. The decompiled fade of dark pixels
	// to the fog colour is left out because it blacked out the zoomed view.
	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" "RenderType" = "Transparent" "Queue" = "Transparent" }
		Pass
		{
			Name "ForwardOnly"
			Tags { "LightMode" = "ForwardOnly" }
			Blend SrcAlpha OneMinusSrcAlpha
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
			TEXTURE2D(_SampleTexture2D_ddb5d4c0b06f43db9a156cab155c58c9_Texture_1_Texture2D);
			SAMPLER(sampler_SampleTexture2D_ddb5d4c0b06f43db9a156cab155c58c9_Texture_1_Texture2D);
			float _DistanceParallax;
			float _OffsetParallax;
			float _Ads;

			struct Attributes { float4 vertex : POSITION; float2 uv : TEXCOORD0; UNITY_VERTEX_INPUT_INSTANCE_ID };
			struct Varyings { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; float3 positionRWS : TEXCOORD1; UNITY_VERTEX_OUTPUT_STEREO };

			Varyings vert(Attributes v)
			{
				Varyings o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.positionRWS = TransformObjectToWorld(v.vertex.xyz);
				o.positionCS = TransformWorldToHClip(o.positionRWS);
				o.uv = v.uv;
				return o;
			}

			float4 frag(Varyings i) : SV_Target
			{
				// Camera-relative rendering: the camera sits at the origin, so -positionRWS points from the lens to the eye.
				float3 forward = -UNITY_MATRIX_V[2].xyz;
				float eyeDepth = dot(-i.positionRWS, forward);
				float notAimed = 1 - _Ads * _Ads;
				float scale = notAimed * _DistanceParallax * eyeDepth;
				float2 viewXY = mul(UNITY_MATRIX_V, float4(i.positionRWS, 1)).xy;
				float2 maskUv = i.uv * scale + viewXY * (notAimed * _OffsetParallax) + (0.5 - 0.5 * scale);
				float mask = SAMPLE_TEXTURE2D(_SampleTexture2D_ddb5d4c0b06f43db9a156cab155c58c9_Texture_1_Texture2D,
					sampler_SampleTexture2D_ddb5d4c0b06f43db9a156cab155c58c9_Texture_1_Texture2D, maskUv).x;
				float3 scene = SAMPLE_TEXTURE2D(_RenderTex, sampler_RenderTex, i.uv).rgb;
				float reticle = 1 - SAMPLE_TEXTURE2D(_Crosshair, sampler_Crosshair, i.uv).a;
				// The scope camera renders without exposure control; match the main camera's exposure.
				// Hip-fire: the screen is see-through so the lens glass and tube behind it show; it fades in while aiming.
				float alpha = saturate(_Ads * 4);
				clip(alpha - 0.001);
				return float4(scene * mask * reticle * GetCurrentExposureMultiplier(), alpha);
			}
			ENDHLSL
		}
	}
}
