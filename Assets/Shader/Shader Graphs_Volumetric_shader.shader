Shader "Shader Graphs/Volumetric_shader"
{
	Properties
	{
		_Intensity ("Intensity", Float) = 0.1
		_Distance ("Distance", Float) = 0
		_Distance_from_camera ("Distance from camera", Float) = 0
		_Color ("Color", Color) = (0,0,0,0)
		_Fresnel ("Fresnel", Float) = 5.88
		_Speed ("Speed", Range(0, 1)) = 0
		_BlackoutEmissionMultiplier ("BlackoutEmissionMultiplier", Float) = 1
		[NoScaleOffset] _Texture2DAsset_023f49b7d3b748c68a57cfe8e0a01741_Out_0_Texture2D ("Texture2D", 2D) = "white" {}
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
	// Hand translation of the original ForwardOnly fragment program (the decompiled one reads HDRP's
	// global buffers incorrectly and draws nothing). Formula taken verbatim from the decompiled code:
	//   alpha = camFade * depthFade * saturate(_Intensity) * (noise*0.7+0.3)
	//           * (1 - min(pow(1 - saturate(N.V), _Fresnel) * 1.328125, 1)) * _BlackoutEmissionMultiplier
	//   camFade   = saturate((saturate((dist(camera, object) - _Distance_from_camera) * 0.1) - 0.06176852) * 2.3288088)
	//   depthFade = min(max(sceneEyeDepth - fragmentEyeDepth, 0), 5) / _Distance
	//   noise     = tex.r at uv * (0.65, 3) + (_Time.y * _Speed, 0)
	//   colour    = _Color * _DeExposureMultiplier, premultiplied alpha
	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" "Queue" = "Transparent" "RenderType" = "Transparent" }
		Pass
		{
			Name "ForwardOnly"
			Tags { "LightMode" = "ForwardOnly" }
			Blend One OneMinusSrcAlpha
			ZWrite Off
			ZTest LEqual
			Cull [_CullModeForward]

			HLSLPROGRAM
			#pragma vertex Vert
			#pragma fragment Frag
			#pragma target 4.5
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

			TEXTURE2D(_Texture2DAsset_023f49b7d3b748c68a57cfe8e0a01741_Out_0_Texture2D);
			SAMPLER(sampler_Texture2DAsset_023f49b7d3b748c68a57cfe8e0a01741_Out_0_Texture2D);

			CBUFFER_START(UnityPerMaterial)
			float _Intensity;
			float _Distance;
			float _Distance_from_camera;
			float4 _Color;
			float _Fresnel;
			float _Speed;
			float _BlackoutEmissionMultiplier;
			CBUFFER_END

			struct Attributes { float3 positionOS : POSITION; float3 normalOS : NORMAL; float2 uv : TEXCOORD0; };
			struct Varyings { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; float3 normalWS : TEXCOORD1; float3 positionRWS : TEXCOORD2; };

			Varyings Vert(Attributes input)
			{
				Varyings output;
				output.positionRWS = TransformObjectToWorld(input.positionOS);
				output.positionCS = TransformWorldToHClip(output.positionRWS);
				output.normalWS = TransformObjectToWorldNormal(input.normalOS);
				output.uv = input.uv;
				return output;
			}

			float4 Frag(Varyings input) : SV_Target
			{
				float3 n = normalize(input.normalWS);
				float3 v = GetWorldSpaceNormalizeViewDir(input.positionRWS);
				float fresnel = 1.0 - min(pow(1.0 - saturate(dot(n, v)), _Fresnel) * 1.328125, 1.0);

				float2 uv = float2(input.uv.x * 0.65 + _Time.y * _Speed, input.uv.y * 3.0);
				float noise = SAMPLE_TEXTURE2D(_Texture2DAsset_023f49b7d3b748c68a57cfe8e0a01741_Out_0_Texture2D, sampler_Texture2DAsset_023f49b7d3b748c68a57cfe8e0a01741_Out_0_Texture2D, uv).r;

				float sceneEye = LinearEyeDepth(LoadCameraDepth(uint2(input.positionCS.xy)), _ZBufferParams);
				float depthFade = min(max(sceneEye - input.positionCS.w, 0.0), 5.0) / _Distance;

				// Object pivot relative to the camera (HDRP object matrices are camera-relative).
				float camDist = length(GetObjectToWorldMatrix()._m03_m13_m23);
				float camFade = saturate((saturate((camDist - _Distance_from_camera) * 0.1) - 0.06176852) * 2.3288088);

				float alpha = camFade * depthFade * saturate(_Intensity) * (noise * 0.7 + 0.3) * fresnel;
				alpha *= _BlackoutEmissionMultiplier;
				float3 col = _Color.rgb * _DeExposureMultiplier;
				return float4(col * alpha, alpha);
			}
			ENDHLSL
		}
	}
	Fallback Off
}
