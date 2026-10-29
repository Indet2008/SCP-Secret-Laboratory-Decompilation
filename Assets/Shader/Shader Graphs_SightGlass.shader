Shader "Shader Graphs/SightGlass"
{
	Properties
		{
			_MinMaxDistance ("MinMaxDistance", Vector) = (0,1,0,0)
			_RemapOut ("RemapOut", Vector) = (0,1,0,0)
			[NoScaleOffset] _BaseColorMap ("BaseColorMap", 2D) = "white" {}
			[NoScaleOffset] _MaskMap ("MaskMap", 2D) = "white" {}
			[NoScaleOffset] _NormalMap ("NormalMap", 2D) = "white" {}
			[NoScaleOffset] _HDRPLit_f26a4c9ecbb54d64a38b6207433f7ca6_DetailMap_913208011_Texture2D ("Texture2D", 2D) = "white" {}
			[NoScaleOffset] _HDRPLit_f26a4c9ecbb54d64a38b6207433f7ca6_EmissiveColorMap_243130236_Texture2D ("Texture2D", 2D) = "white" {}
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
	// Hand-written replacement for the original SightGlass graph (optic glass that fades with eye distance).
	// Opacity = RemapOut remapped from the camera distance between MinMaxDistance, so the glass is
	// see-through up close (when aiming) and visible from further away.
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

			TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap);
			float4 _MinMaxDistance;
			float4 _RemapOut;

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
				float dist = length(i.positionWS);
				float t = saturate((dist - _MinMaxDistance.x) / max(_MinMaxDistance.y - _MinMaxDistance.x, 1e-4));
				float alpha = saturate(lerp(_RemapOut.x, _RemapOut.y, t));
				float4 baseCol = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, i.uv);
				float fresnel = pow(1 - saturate(abs(dot(normalize(i.normalWS), normalize(-i.positionWS)))), 4);
				// Mostly clear optic glass: a light grey tint that only builds up from further away,
				// darker towards the rim of the lens, plus a faint fresnel reflection.
				float rim = smoothstep(0.25, 0.5, length(i.uv - 0.5));
				float tint = alpha * baseCol.a * (0.12 + 0.25 * rim);
				float3 col = baseCol.rgb * 0.05 + fresnel * 0.06;
				float a = saturate(tint + fresnel * 0.15 * alpha);
				return float4(col * a, a);
			}
			ENDHLSL
		}
	}
}
