Shader "Shader Graphs/ParticleUnlit_graph"
{
	Properties
		{
			[NoScaleOffset] _DiffuseTexture ("DiffuseTexture", 2D) = "white" {}
			[HDR] _Emissive ("Emissive", Color) = (0,0,0,0)
			[Toggle(_FLIPBOOK)] _FLIPBOOK ("Flipbook", Float) = 0
			_Width_Height ("Width & Height", Vector) = (1,1,0,0)
			_Tile ("Tile", Float) = 0
			_Speed ("Speed", Float) = 1
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
			[HideInInspector] _AlphaCutoff ("Alpha Cutoff", Float) = 0.5
		}
	// Hand-written replacement for the original ParticleUnlit graph (HDRP unlit, used by particle systems).
	// Color = DiffuseTexture (optional in-shader flipbook) * particle vertex color * Emissive.
	// Blend state comes from the material's HDRP surface options (_SrcBlend/_DstBlend/_ZWrite/_CullMode).
	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" "RenderType" = "Transparent" "Queue" = "Transparent" "IgnoreProjector" = "True" }
		Pass
		{
			Name "ForwardOnly"
			Tags { "LightMode" = "ForwardOnly" }
			Blend [_SrcBlend] [_DstBlend], [_AlphaSrcBlend] [_AlphaDstBlend]
			ZWrite [_ZWrite]
			ZTest [_ZTestTransparent]
			Cull [_CullMode]

			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.5
			#pragma multi_compile_instancing
			#pragma shader_feature_local _FLIPBOOK

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

			TEXTURE2D(_DiffuseTexture); SAMPLER(sampler_DiffuseTexture);
			float4 _Emissive;
			float4 _Width_Height;
			float _Tile;
			float _Speed;
			float _BlendMode;
			float _SurfaceType;
			float _AlphaCutoffEnable;
			float _AlphaCutoff;

			struct Attributes { float4 vertex : POSITION; float4 color : COLOR; float2 uv : TEXCOORD0; UNITY_VERTEX_INPUT_INSTANCE_ID };
			struct Varyings { float4 positionCS : SV_POSITION; float4 color : COLOR; float2 uv : TEXCOORD0; UNITY_VERTEX_OUTPUT_STEREO };

			Varyings vert(Attributes v)
			{
				Varyings o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.positionCS = TransformWorldToHClip(TransformObjectToWorld(v.vertex.xyz));
				o.color = v.color;
				o.uv = v.uv;
				return o;
			}

			float4 frag(Varyings i) : SV_Target
			{
				float2 uv = i.uv;
				#ifdef _FLIPBOOK
				float2 size = max(_Width_Height.xy, 1);
				float tiles = size.x * size.y;
				float tile = floor(fmod(_Tile + _TimeParameters.x * _Speed, tiles));
				float tileX = fmod(tile, size.x);
				float tileY = size.y - 1 - floor(tile / size.x);
				uv = (uv + float2(tileX, tileY)) / size;
				#endif
				float4 tex = SAMPLE_TEXTURE2D(_DiffuseTexture, sampler_DiffuseTexture, uv);
				// Base color is screen-relative; Emissive is physical HDR emission, so it is pre-exposed like HDRP emission.
				float3 baseColor = tex.rgb * i.color.rgb;
				float4 col = float4(baseColor + baseColor * _Emissive.rgb * GetCurrentExposureMultiplier(), tex.a * i.color.a);
				if (_AlphaCutoffEnable > 0.5) clip(col.a - _AlphaCutoff);
				// HDRP blend modes: Alpha and Additive expect premultiplied color, Premultiply (4) does not.
				if (_SurfaceType > 0.5 && abs(_BlendMode - 4) > 0.5) col.rgb *= col.a;
				return col;
			}
			ENDHLSL
		}
	}
}
