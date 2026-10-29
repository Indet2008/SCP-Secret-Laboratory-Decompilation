Shader "Shader Graphs/scp 2176"
{
	Properties
		{
			_Color ("Color", Color) = (0,0,0,0)
			[NoScaleOffset] _Diffuse ("Diffuse", 2D) = "white" {}
			_Smoothness ("Smoothness", Range(0, 1)) = 0.95
			_Refracted_color ("Refracted color", Color) = (1,1,1,0)
			_Fresnel_thinness ("Fresnel thinness", Float) = 1
			[HDR] _Fresnel_color ("Fresnel color", Color) = (1,1,1,0)
			_Distortion_intensity ("Distortion intensity", Range(0, 100)) = 1
			_Distortion_blur ("Distortion blur", Range(0, 1)) = 0
			[NoScaleOffset] _Noise ("Noise", 2D) = "white" {}
			_Noise_Intensity ("Noise Intensity", Range(0, 10)) = 1
			_Noise_Speed ("Noise Speed", Float) = 1
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
			[HideInInspector] _BlendMode ("Float", Float) = 4
			[HideInInspector] _SrcBlend ("Float", Float) = 1
			[HideInInspector] _DstBlend ("Float", Float) = 0
			[HideInInspector] _DstBlend2 ("Float", Float) = 0
			[HideInInspector] _AlphaSrcBlend ("Float", Float) = 1
			[HideInInspector] _AlphaDstBlend ("Float", Float) = 0
			[ToggleUI] [HideInInspector] _ZWrite ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _TransparentZWrite ("Boolean", Float) = 0
			[HideInInspector] _CullMode ("Float", Float) = 2
			[ToggleUI] [HideInInspector] _EnableFogOnTransparent ("Boolean", Float) = 1
			[HideInInspector] _CullModeForward ("Float", Float) = 2
			[Enum(Front, 1, Back, 2)] [HideInInspector] _TransparentCullMode ("Float", Float) = 2
			[Enum(UnityEngine.Rendering.HighDefinition.OpaqueCullMode)] [HideInInspector] _OpaqueCullMode ("Float", Float) = 2
			[HideInInspector] _ZTestDepthEqualForOpaque ("Float", Float) = 4
			[Enum(UnityEngine.Rendering.CompareFunction)] [HideInInspector] _ZTestTransparent ("Float", Float) = 4
			[ToggleUI] [HideInInspector] _TransparentBackfaceEnable ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _RequireSplitLighting ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _ReceivesSSR ("Boolean", Float) = 1
			[ToggleUI] [HideInInspector] _ReceivesSSRTransparent ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _EnableBlendModePreserveSpecularLighting ("Boolean", Float) = 1
			[ToggleUI] [HideInInspector] _SupportDecals ("Boolean", Float) = 1
			[ToggleUI] [HideInInspector] _ExcludeFromTUAndAA ("Boolean", Float) = 0
			[HideInInspector] _StencilRef ("Float", Float) = 0
			[HideInInspector] _StencilWriteMask ("Float", Float) = 6
			[HideInInspector] _StencilRefDepth ("Float", Float) = 0
			[HideInInspector] _StencilWriteMaskDepth ("Float", Float) = 9
			[HideInInspector] _StencilRefMV ("Float", Float) = 32
			[HideInInspector] _StencilWriteMaskMV ("Float", Float) = 41
			[HideInInspector] _StencilRefDistortionVec ("Float", Float) = 4
			[HideInInspector] _StencilWriteMaskDistortionVec ("Float", Float) = 4
			[HideInInspector] _StencilWriteMaskGBuffer ("Float", Float) = 15
			[HideInInspector] _StencilRefGBuffer ("Float", Float) = 2
			[HideInInspector] _ZTestGBuffer ("Float", Float) = 4
			[ToggleUI] [HideInInspector] _RayTracing ("Boolean", Float) = 0
			[Enum(None, 0, Planar, 1, Sphere, 2, Thin, 3)] [HideInInspector] _RefractionModel ("Float", Float) = 0
			[Enum(Standard, 1)] [HideInInspector] _MaterialID ("_MaterialID", Float) = 1
			[HideInInspector] _MaterialTypeMask ("_MaterialTypeMask", Float) = 2
			[ToggleUI] [HideInInspector] _TransmissionEnable ("Boolean", Float) = 1
			[HideInInspector] [NoScaleOffset] unity_Lightmaps ("unity_Lightmaps", 2DArray) = "" {}
			[HideInInspector] [NoScaleOffset] unity_LightmapsInd ("unity_LightmapsInd", 2DArray) = "" {}
			[HideInInspector] [NoScaleOffset] unity_ShadowMasks ("unity_ShadowMasks", 2DArray) = "" {}
		}
	// Hand-written replacement for the original "scp 2176" graph (glass bulb with fresnel glow and noise flicker).
	// The screen-space refraction of the original is not reproduced; the tinted glass is blended instead.
	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" "RenderType" = "Transparent" "Queue" = "Transparent" }
		Pass
		{
			Name "ForwardOnly"
			Tags { "LightMode" = "ForwardOnly" }
			Blend [_SrcBlend] [_DstBlend], [_AlphaSrcBlend] [_AlphaDstBlend]
			ZWrite [_ZWrite]
			Cull [_CullMode]

			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.5
			#pragma multi_compile_instancing

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

			TEXTURE2D(_Diffuse); SAMPLER(sampler_Diffuse);
			TEXTURE2D(_Noise); SAMPLER(sampler_Noise);
			float4 _Color;
			float4 _Refracted_color;
			float4 _Fresnel_color;
			float _Fresnel_thinness;
			float _Noise_Intensity;
			float _Noise_Speed;
			float _SurfaceType;
			float _BlendMode;

			struct Attributes { float4 vertex : POSITION; float3 normal : NORMAL; float2 uv : TEXCOORD0; UNITY_VERTEX_INPUT_INSTANCE_ID };
			struct Varyings { float4 positionCS : SV_POSITION; float3 positionWS : TEXCOORD0; float3 normalWS : TEXCOORD1; float2 uv : TEXCOORD2; UNITY_VERTEX_OUTPUT_STEREO };

			Varyings vert(Attributes v)
			{
				Varyings o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.positionWS = TransformObjectToWorld(v.vertex.xyz);
				o.normalWS = TransformObjectToWorldNormal(v.normal);
				o.positionCS = TransformWorldToHClip(o.positionWS);
				o.uv = v.uv;
				return o;
			}

			float4 frag(Varyings i) : SV_Target
			{
				float3 viewDir = normalize(-i.positionWS);
				float3 n = normalize(i.normalWS);
				float fresnel = pow(1 - saturate(abs(dot(n, viewDir))), max(_Fresnel_thinness, 0.01));
				float noise = SAMPLE_TEXTURE2D(_Noise, sampler_Noise, i.uv + _TimeParameters.x * _Noise_Speed * 0.05).r;
				float flicker = lerp(1, noise, saturate(_Noise_Intensity / 10));
				float3 baseCol = _Color.rgb * SAMPLE_TEXTURE2D(_Diffuse, sampler_Diffuse, i.uv).rgb * _Refracted_color.rgb;
				float3 col = baseCol + _Fresnel_color.rgb * fresnel * flicker;
				float a = saturate(_Color.a + fresnel * 0.5);
				if (_SurfaceType > 0.5 && abs(_BlendMode - 4) > 0.5) col *= a;
				else if (_SurfaceType > 0.5) col = col * a;   // premultiply mode: color is authored as glass tint
				return float4(col, a);
			}
			ENDHLSL
		}
	}
}
