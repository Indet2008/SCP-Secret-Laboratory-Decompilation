Shader "Shader Graphs/Disrupted"
{
	Properties
		{
			_Dissolve ("Dissolve", Range(0, 1)) = 0
			[HDR] _DissolveColor ("DissolveColor", Color) = (0,0.6754479,1,1)
			[NoScaleOffset] _BaseColorMap ("BaseColorMap", 2D) = "white" {}
			[NoScaleOffset] _NormalMap ("NormalMap", 2D) = "white" {}
			[NoScaleOffset] _EmissionMap ("EmissionMap", 2D) = "white" {}
			[HDR] _Emission ("Emission", Color) = (0,0,0,0)
			[ToggleUI] _UseMaskMap ("UseMaskMap", Float) = 1
			[NoScaleOffset] _MaskMap ("MaskMap", 2D) = "white" {}
			[NoScaleOffset] _HDRPLit_9ccede5c759f47328be7a7de0be3904b_DetailMap_913208011_Texture2D ("Texture2D", 2D) = "white" {}
			[HideInInspector] _EmissionColor ("Color", Color) = (1,1,1,1)
			[HideInInspector] _RenderQueueType ("Float", Float) = 1
			[ToggleUI] [HideInInspector] _AddPrecomputedVelocity ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _DepthOffsetEnable ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _ConservativeDepthOffsetEnable ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _TransparentWritingMotionVec ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _AlphaCutoffEnable ("Boolean", Float) = 1
			[HideInInspector] _TransparentSortPriority ("_TransparentSortPriority", Float) = 0
			[ToggleUI] [HideInInspector] _UseShadowThreshold ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _DoubleSidedEnable ("Boolean", Float) = 1
			[Enum(Flip, 0, Mirror, 1, None, 2)] [HideInInspector] _DoubleSidedNormalMode ("Float", Float) = 0
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
	// Hand-written replacement for the original Disrupted graph (particle disruptor disintegration).
	// The ragdoll's textures are copied onto instances of TemplateDissolve; _Dissolve (0..1) eats the body
	// away with object-space noise and the burning edge glows in _DissolveColor.
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

			TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap);
			float _Dissolve;
			float4 _DissolveColor;
			float4 _Emission;

			struct Attributes { float4 vertex : POSITION; float3 normal : NORMAL; float2 uv : TEXCOORD0; UNITY_VERTEX_INPUT_INSTANCE_ID };
			struct Varyings { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; float3 positionOS : TEXCOORD1; float3 normalWS : TEXCOORD2; UNITY_VERTEX_OUTPUT_STEREO };

			Varyings vert(Attributes v)
			{
				Varyings o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.positionCS = TransformWorldToHClip(TransformObjectToWorld(v.vertex.xyz));
				o.uv = v.uv;
				o.positionOS = v.vertex.xyz;
				o.normalWS = TransformObjectToWorldNormal(v.normal);
				return o;
			}

			float Hash3(float3 p) { return frac(sin(dot(p, float3(12.9898, 78.233, 37.719))) * 43758.5453); }

			float ValueNoise(float3 p)
			{
				float3 i = floor(p);
				float3 f = frac(p);
				f = f * f * (3 - 2 * f);
				float n000 = Hash3(i), n100 = Hash3(i + float3(1, 0, 0)), n010 = Hash3(i + float3(0, 1, 0)), n110 = Hash3(i + float3(1, 1, 0));
				float n001 = Hash3(i + float3(0, 0, 1)), n101 = Hash3(i + float3(1, 0, 1)), n011 = Hash3(i + float3(0, 1, 1)), n111 = Hash3(i + float3(1, 1, 1));
				return lerp(lerp(lerp(n000, n100, f.x), lerp(n010, n110, f.x), f.y), lerp(lerp(n001, n101, f.x), lerp(n011, n111, f.x), f.y), f.z);
			}

			float4 frag(Varyings i) : SV_Target
			{
				// Ragdoll bones are scaled differently per mesh; 40 cells per unit gives fine, burning-paper-like holes.
				float3 p = i.positionOS * 40;
				float n = ValueNoise(p) * 0.65 + ValueNoise(p * 2.7) * 0.35;
				float edge = n - _Dissolve * 1.1;
				clip(edge);
				float3 albedo = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, i.uv).rgb;
				// No HDRP light loop here: a soft top light keeps the body readable for the 1.5 s it takes to vanish.
				float lambert = 0.35 + 0.65 * saturate(normalize(i.normalWS).y * 0.5 + 0.5);
				float3 col = albedo * lambert * 0.25;
				float glow = (1 - saturate(edge / 0.08)) * step(0.001, _Dissolve);
				col += (_DissolveColor.rgb * glow * 4 + _Emission.rgb) * GetCurrentExposureMultiplier();
				return float4(col, 1);
			}
			ENDHLSL
		}
	}
}
