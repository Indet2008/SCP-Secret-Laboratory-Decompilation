Shader "Shader Graphs/Scp127Tier"
{
	Properties
		{
			_Metallic ("Metallic", Float) = 0
			_Smoothness ("Smoothness", Float) = 0
			_AlphaThld ("AlphaThld", Float) = 0
			_FillTier1 ("FillTier1", Range(0, 1)) = 0.39
			_BaseColorTier1 ("BaseColorTier1", Color) = (0,0,0,0)
			[HDR] _EmissionColorTier1 ("EmissionColorTier1", Color) = (0,0,0,0)
			_FillTier2 ("FillTier2", Range(0, 1)) = 0.39
			_BaseColorTier2 ("BaseColorTier2", Color) = (0,0,0,0)
			[HDR] _EmissionColorTier2 ("EmissionColorTier2", Color) = (0,0,0,0)
			_FillTier3 ("FillTier3", Range(0, 1)) = 0.39
			_BaseColorTier3 ("BaseColorTier3", Color) = (0,0,0,0)
			[HDR] _EmissionColorTier3 ("EmissionColorTier3", Color) = (0,0,0,0)
			[NoScaleOffset] _SampleTexture2D_b9e60437553047b5bf4987278afd92f2_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
			[NoScaleOffset] [Normal] _SampleTexture2D_4162be48e6074f249c17d3049de7b871_Texture_1_Texture2D ("Texture2D", 2D) = "bump" {}
			[NoScaleOffset] _SampleTexture2D_d3f860d6fd3f4b89a49b1727ca922b3d_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
			[HideInInspector] _EmissionColor ("Color", Color) = (1,1,1,1)
			[HideInInspector] _RenderQueueType ("Float", Float) = 1
			[ToggleUI] [HideInInspector] _AddPrecomputedVelocity ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _DepthOffsetEnable ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _ConservativeDepthOffsetEnable ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _TransparentWritingMotionVec ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _AlphaCutoffEnable ("Boolean", Float) = 1
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
			[ToggleUI] [HideInInspector] _RequireSplitLighting ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _ReceivesSSR ("Boolean", Float) = 1
			[ToggleUI] [HideInInspector] _ReceivesSSRTransparent ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _EnableBlendModePreserveSpecularLighting ("Boolean", Float) = 1
			[ToggleUI] [HideInInspector] _SupportDecals ("Boolean", Float) = 1
			[ToggleUI] [HideInInspector] _ExcludeFromTUAndAA ("Boolean", Float) = 0
			[HideInInspector] _StencilRef ("Float", Float) = 0
			[HideInInspector] _StencilWriteMask ("Float", Float) = 6
			[HideInInspector] _StencilRefDepth ("Float", Float) = 8
			[HideInInspector] _StencilWriteMaskDepth ("Float", Float) = 9
			[HideInInspector] _StencilRefMV ("Float", Float) = 40
			[HideInInspector] _StencilWriteMaskMV ("Float", Float) = 41
			[HideInInspector] _StencilRefDistortionVec ("Float", Float) = 4
			[HideInInspector] _StencilWriteMaskDistortionVec ("Float", Float) = 4
			[HideInInspector] _StencilWriteMaskGBuffer ("Float", Float) = 15
			[HideInInspector] _StencilRefGBuffer ("Float", Float) = 10
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
	// Hand-written replacement for the original Scp127Tier graph. The mask texture holds one tier line per
	// channel (R/G/B = Tier1/2/3); each line fills from the bottom up to _FillTierN and is tinted with
	// _BaseColorTierN plus HDR _EmissionColorTierN (set per frame by Scp127TierIndicator).
	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" "RenderType" = "Transparent" "Queue" = "Transparent" }
		Pass
		{
			Name "ForwardOnly"
			Tags { "LightMode" = "ForwardOnly" }
			Blend One OneMinusSrcAlpha
			ZWrite Off
			Cull Back

			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.5
			#pragma multi_compile_instancing

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

			TEXTURE2D(_SampleTexture2D_b9e60437553047b5bf4987278afd92f2_Texture_1_Texture2D); SAMPLER(sampler_SampleTexture2D_b9e60437553047b5bf4987278afd92f2_Texture_1_Texture2D);
			float _FillTier1, _FillTier2, _FillTier3;
			float4 _BaseColorTier1, _BaseColorTier2, _BaseColorTier3;
			float4 _EmissionColorTier1, _EmissionColorTier2, _EmissionColorTier3;

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

			float4 frag(Varyings i) : SV_Target
			{
				float3 m = SAMPLE_TEXTURE2D(_SampleTexture2D_b9e60437553047b5bf4987278afd92f2_Texture_1_Texture2D, sampler_SampleTexture2D_b9e60437553047b5bf4987278afd92f2_Texture_1_Texture2D, i.uv).rgb;
				float3 fill = step(i.uv.yyy, float3(_FillTier1, _FillTier2, _FillTier3));
				float3 w = m * fill;
				float exposure = GetCurrentExposureMultiplier();
				// Base colour is an albedo in the original lit graph; this unlit pass approximates the dim
				// facility lighting instead of drawing it at full brightness.
				const float litApprox = 0.08;
				float3 col = w.x * (_BaseColorTier1.rgb * litApprox + _EmissionColorTier1.rgb * exposure)
				           + w.y * (_BaseColorTier2.rgb * litApprox + _EmissionColorTier2.rgb * exposure)
				           + w.z * (_BaseColorTier3.rgb * litApprox + _EmissionColorTier3.rgb * exposure);
				float a = saturate(max(w.x, max(w.y, w.z)));
				return float4(col * a, a);
			}
			ENDHLSL
		}
	}
}
