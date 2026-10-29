Shader "SCPSL/Liquid"
{
	Properties
		{
			[HideInInspector] _AlphaCutoff ("Alpha Cutoff ", Range(0, 1)) = 0.5
			[ASEBegin] _Fill ("Fill", Range(-5, 5)) = 0
			[HDR] _Color ("Color", Color) = (0.4,0.4745098,0.4,1)
			[HDR] _EmissiveColor ("_EmissiveColor", Color) = (0,0,0,0)
			_WobbleZ ("WobbleZ", Float) = 0
			[ASEEnd] _WobbleX ("WobbleX", Float) = 0
			[HideInInspector] _RenderQueueType ("Render Queue Type", Float) = 1
			[HideInInspector] _StencilRef ("Stencil Ref", Float) = 0
			[HideInInspector] _StencilWriteMask ("Stencil Write Mask", Float) = 3
			[HideInInspector] _StencilRefDepth ("Stencil Ref Depth", Float) = 0
			[HideInInspector] _StencilWriteMaskDepth ("Stencil Write Mask Depth", Float) = 8
			[HideInInspector] _StencilRefMV ("Stencil Ref MV", Float) = 32
			[HideInInspector] _StencilWriteMaskMV ("Stencil Write Mask MV", Float) = 32
			[HideInInspector] _StencilRefDistortionVec ("Stencil Ref Distortion Vec", Float) = 2
			[HideInInspector] _StencilWriteMaskDistortionVec ("Stencil Write Mask Distortion Vec", Float) = 2
			[HideInInspector] _StencilWriteMaskGBuffer ("Stencil Write Mask GBuffer", Float) = 3
			[HideInInspector] _StencilRefGBuffer ("Stencil Ref GBuffer", Float) = 2
			[HideInInspector] _ZTestGBuffer ("ZTest GBuffer", Float) = 4
			[ToggleUI] [HideInInspector] _RequireSplitLighting ("Require Split Lighting", Float) = 0
			[ToggleUI] [HideInInspector] _ReceivesSSR ("Receives SSR", Float) = 1
			[HideInInspector] _SurfaceType ("Surface Type", Float) = 1
			[HideInInspector] _BlendMode ("Blend Mode", Float) = 0
			[HideInInspector] _SrcBlend ("Src Blend", Float) = 1
			[HideInInspector] _DstBlend ("Dst Blend", Float) = 0
			[HideInInspector] _AlphaSrcBlend ("Alpha Src Blend", Float) = 1
			[HideInInspector] _AlphaDstBlend ("Alpha Dst Blend", Float) = 0
			[ToggleUI] [HideInInspector] _ZWrite ("ZWrite", Float) = 0
			[ToggleUI] [HideInInspector] _TransparentZWrite ("Transparent ZWrite", Float) = 0
			[HideInInspector] _CullMode ("Cull Mode", Float) = 2
			[HideInInspector] _TransparentSortPriority ("Transparent Sort Priority", Float) = 0
			[ToggleUI] [HideInInspector] _EnableFogOnTransparent ("Enable Fog", Float) = 1
			[HideInInspector] _CullModeForward ("Cull Mode Forward", Float) = 2
			[Enum(UnityEditor.Rendering.HighDefinition.TransparentCullMode)] [HideInInspector] _TransparentCullMode ("Transparent Cull Mode", Float) = 1
			[HideInInspector] _ZTestDepthEqualForOpaque ("ZTest Depth Equal For Opaque", Float) = 4
			[Enum(UnityEngine.Rendering.CompareFunction)] [HideInInspector] _ZTestTransparent ("ZTest Transparent", Float) = 4
			[ToggleUI] [HideInInspector] _TransparentBackfaceEnable ("Transparent Backface Enable", Float) = 0
			[ToggleUI] [HideInInspector] _AlphaCutoffEnable ("Alpha Cutoff Enable", Float) = 0
			[ToggleUI] [HideInInspector] _UseShadowThreshold ("Use Shadow Threshold", Float) = 0
			[ToggleUI] [HideInInspector] _DoubleSidedEnable ("Double Sided Enable", Float) = 0
			[Enum(Flip, 0, Mirror, 1, None, 2)] [HideInInspector] _DoubleSidedNormalMode ("Double Sided Normal Mode", Float) = 2
			[HideInInspector] _DoubleSidedConstants ("DoubleSidedConstants", Vector) = (1,1,-1,0)
			[HideInInspector] _DistortionEnable ("_DistortionEnable", Float) = 0
			[HideInInspector] _DistortionOnly ("_DistortionOnly", Float) = 0
			[ToggleUI] [HideInInspector] _TransparentWritingMotionVec ("Transparent Writing MotionVec", Float) = 0
			[Enum(UnityEditor.Rendering.HighDefinition.OpaqueCullMode)] [HideInInspector] _OpaqueCullMode ("Opaque Cull Mode", Float) = 2
			[ToggleUI] [HideInInspector] _SupportDecals ("Support Decals", Float) = 1
			[ToggleUI] [HideInInspector] _ReceivesSSRTransparent ("Receives SSR Transparent", Float) = 0
			[HideInInspector] _EmissionColor ("Color", Color) = (1,1,1,1)
			[HideInInspector] _UnlitColorMap_MipInfo ("_UnlitColorMap_MipInfo", Vector) = (0,0,0,0)
			[Enum(Auto, 0, On, 1, Off, 2)] [HideInInspector] _DoubleSidedGIMode ("Double sided GI mode", Float) = 0
		}
	// Hand-written replacement for the original Amplify "SCPSL/Liquid" shader (wobbling fill-level liquid).
	// Pixels above the fill plane (world height relative to the object's pivot, tilted by WobbleX/Z) are clipped;
	// back faces show the liquid surface. LiquidWobble drives _WobbleX/_WobbleZ at runtime.
	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" "RenderType" = "Transparent" "Queue" = "Transparent" }
		Pass
		{
			Name "ForwardOnly"
			Tags { "LightMode" = "ForwardOnly" }
			Blend [_SrcBlend] [_DstBlend], [_AlphaSrcBlend] [_AlphaDstBlend]
			// The liquid is opaque (alpha 1) even on transparent-queue materials (first-person 207 etc.); without depth
			// its back faces and the bottle glass sort wrongly and the bottle looks see-through.
			ZWrite On
			Cull Off

			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.5
			#pragma multi_compile_instancing

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

			float _Fill;
			float4 _Color;
			float4 _EmissiveColor;
			float _WobbleX;
			float _WobbleZ;
			float _SurfaceType;
			float _BlendMode;

			struct Attributes { float4 vertex : POSITION; float3 normal : NORMAL; UNITY_VERTEX_INPUT_INSTANCE_ID };
			struct Varyings { float4 positionCS : SV_POSITION; float3 positionWS : TEXCOORD0; float3 normalWS : TEXCOORD1; float fillHeight : TEXCOORD2; UNITY_VERTEX_OUTPUT_STEREO };

			Varyings vert(Attributes v)
			{
				Varyings o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				float3 positionWS = TransformObjectToWorld(v.vertex.xyz);
				float3 pivotWS = TransformObjectToWorld(float3(0, 0, 0));
				float3 rel = positionWS - pivotWS;
				o.fillHeight = rel.y + rel.x * _WobbleX + rel.z * _WobbleZ;
				o.positionWS = positionWS;
				o.normalWS = TransformObjectToWorldNormal(v.normal);
				o.positionCS = TransformWorldToHClip(positionWS);
				return o;
			}

			float4 frag(Varyings i, bool isFrontFace : SV_IsFrontFace) : SV_Target
			{
				clip(_Fill - i.fillHeight);
				float3 viewDir = normalize(-i.positionWS);   // camera-relative rendering: camera at origin
				float3 n = normalize(isFrontFace ? i.normalWS : -i.normalWS);
				float rim = pow(1 - saturate(dot(n, viewDir)), 3);
				float3 col = _Color.rgb;
				if (!isFrontFace)
					col *= 1.6;                            // liquid surface seen through the top
				col += rim * 0.15 + _EmissiveColor.rgb * GetCurrentExposureMultiplier();
				float a = _Color.a;
				if (_SurfaceType > 0.5 && abs(_BlendMode - 4) > 0.5) col *= a;
				return float4(col, a);
			}
			ENDHLSL
		}
	}
}
