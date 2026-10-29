Shader "Shader Graphs/AmnesticCloudDecal"
{
	Properties
	{
		_RadiusPercent ("RadiusPercent", Float) = 0.8
		_StatusPercent ("StatusPercent", Range(0, 1)) = 1
		_MinPercent ("MinPercent", Range(0, 1)) = 0.1
		_Thickness ("Thickness", Float) = 0.02
		_GradientPower ("GradientPower", Float) = 1.8
		[NoScaleOffset] _SampleTexture2D_191dc57fa34f4cb9857e460eee6a3d59_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[HideInInspector] _DrawOrder ("Draw Order", Float) = 0
		[Enum(Depth Bias, 0, View Bias, 1)] [HideInInspector] _DecalMeshBiasType ("Float", Float) = 0
		[HideInInspector] _DecalMeshDepthBias ("DecalMesh DepthBias", Float) = 0
		[HideInInspector] _DecalMeshViewBias ("DecalMesh ViewBias", Float) = 0
		[HideInInspector] _DecalStencilWriteMask ("Float", Float) = 0
		[HideInInspector] _DecalStencilRef ("Float", Float) = 0
		[ToggleUI] [HideInInspector] _AffectAlbedo ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _AffectEmission ("Boolean", Float) = 1
		[HideInInspector] _DecalColorMask0 ("Float", Float) = 0
		[HideInInspector] _DecalColorMask1 ("Float", Float) = 0
		[HideInInspector] _DecalColorMask2 ("Float", Float) = 0
		[HideInInspector] _DecalColorMask3 ("Float", Float) = 0
	}

	// Hand-written replacement for the ripped shader graph (its decompiled variants did not compile).
	// Same math as the original DBufferProjector / DecalProjectorForwardEmissive passes: a white ring at
	// _RadiusPercent with a dithered radial gradient inside, alpha also driven by the texture and _StatusPercent.
	HLSLINCLUDE
	#pragma target 4.5
	#pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch
	#pragma shader_feature_local_fragment _MATERIAL_AFFECTS_ALBEDO
	#pragma multi_compile_instancing
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
	#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
	#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
	#pragma vertex Vert
	#pragma fragment Frag
	ENDHLSL

	SubShader
	{
		Tags { "RenderPipeline" = "HDRenderPipeline" "QUEUE" = "Geometry+0" "RenderType" = "Opaque" }

		HLSLINCLUDE
		#define UNITY_DECALPROPERTIES_INCLUDED
		TEXTURE2D(_SampleTexture2D_191dc57fa34f4cb9857e460eee6a3d59_Texture_1_Texture2D);
		SAMPLER(sampler_SampleTexture2D_191dc57fa34f4cb9857e460eee6a3d59_Texture_1_Texture2D);

		CBUFFER_START(UnityPerMaterial)
		float _RadiusPercent;
		float _Thickness;
		float _StatusPercent;
		float _MinPercent;
		float _GradientPower;
		float _DrawOrder;
		float _DecalMeshBiasType;
		float _DecalMeshDepthBias;
		float _DecalMeshViewBias;
		CBUFFER_END
		ENDHLSL

		Pass
		{
			Name "DBufferProjector"
			Tags { "LightMode" = "DBufferProjector" }
			Stencil
			{
				WriteMask [_DecalStencilWriteMask]
				Ref [_DecalStencilRef]
				Comp Always
				Pass Replace
			}
			Cull Front
			ZWrite Off
			ZTest Greater
			Blend 0 SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			Blend 1 SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			Blend 2 SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			Blend 3 Zero OneMinusSrcColor
			ColorMask [_DecalColorMask0]
			ColorMask [_DecalColorMask1] 1
			ColorMask [_DecalColorMask2] 2
			ColorMask [_DecalColorMask3] 3

			HLSLPROGRAM
			#pragma multi_compile_fragment DECALS_3RT DECALS_4RT
			#pragma multi_compile_fragment _ DECAL_SURFACE_GRADIENT
			#define SHADERPASS SHADERPASS_DBUFFER_PROJECTOR
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/Decal.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/ShaderPass/DecalSharePass.hlsl"
			#include "AmnesticCloudDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDecal.hlsl"
			ENDHLSL
		}

		Pass
		{
			Name "DecalProjectorForwardEmissive"
			Tags { "LightMode" = "DecalProjectorForwardEmissive" }
			Stencil
			{
				WriteMask [_DecalStencilWriteMask]
				Ref [_DecalStencilRef]
				Comp Always
				Pass Replace
			}
			Cull Front
			ZWrite Off
			ZTest Greater
			Blend 0 SrcAlpha One

			HLSLPROGRAM
			#define _MATERIAL_AFFECTS_EMISSION
			#define SHADERPASS SHADERPASS_FORWARD_EMISSIVE_PROJECTOR
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/Decal.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/ShaderPass/DecalSharePass.hlsl"
			#include "AmnesticCloudDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDecal.hlsl"
			ENDHLSL
		}
	}
	Fallback Off
}
