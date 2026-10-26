Shader "HDRP/HairFadeable"
{
	Properties
		{
			[NoScaleOffset] _BaseColorMap ("Base Color Map", 2D) = "white" {}
			_BaseColor ("Base Color", Color) = (0.5,0.5,0.5,1)
			_AlphaClipThreshold ("Alpha Clip Threshold", Range(0, 1)) = 0
			_AlphaClipThresholdDepthPrepass ("Alpha Clip Threshold Depth Prepass", Range(0, 1)) = 0.9
			_AlphaClipThresholdDepthPostpass ("Alpha Clip Threshold Depth Postpass", Range(0, 1)) = 0.6
			_AlphaThresholdShadow ("Alpha Clip Threshold Shadows", Range(0, 1)) = 0.5
			_uvBaseST ("Base UV Scale Transform", Vector) = (1,1,0,0)
			[NoScaleOffset] [Normal] _NormalMap ("Normal Map", 2D) = "bump" {}
			_NormalScale ("Normal Strength", Range(0, 8)) = 1
			[NoScaleOffset] _MaskMap ("AO Map", 2D) = "white" {}
			[ToggleUI] _LightmapUV ("AO Use Lightmap UV", Float) = 0
			[NoScaleOffset] _SmoothnessMask ("Smoothness Mask", 2D) = "white" {}
			_uvSmoothnessST ("Smoothness UV Scale Transform", Vector) = (20,5,0,0)
			_SmoothnessMin ("Smoothness Min", Range(0, 1)) = 0.3
			_SmoothnessMax ("Smoothness Max", Range(0, 1)) = 0.7
			_SpecularColor ("Specular Color", Color) = (0.6039216,0.3137255,0,1)
			_Specular ("Specular Multiplier", Range(0, 1)) = 1
			_SpecularShift ("Specular Shift", Range(0, 1)) = 0.5
			_SecondarySpecular ("Secondary Specular Multiplier", Range(0, 1)) = 1
			_SecondarySpecularShift ("Secondary Specular Shift", Range(0, 1)) = 0.9
			[HDR] _TransmissionColor ("Transmission Color", Color) = (1,0.8666667,0.627451,1)
			_TransmissionRim ("Transmission Rim", Range(0, 1)) = 0.2
			_Fade ("Fade", Range(0, 1)) = 1
			[HideInInspector] _EmissionColor ("Color", Color) = (1,1,1,1)
			[HideInInspector] _RenderQueueType ("Float", Float) = 4
			[ToggleUI] [HideInInspector] _AddPrecomputedVelocity ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _DepthOffsetEnable ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _ConservativeDepthOffsetEnable ("Boolean", Float) = 0
			[ToggleUI] [HideInInspector] _TransparentWritingMotionVec ("Boolean", Float) = 1
			[ToggleUI] [HideInInspector] _AlphaCutoffEnable ("Boolean", Float) = 1
			[HideInInspector] _TransparentSortPriority ("_TransparentSortPriority", Float) = 0
			[ToggleUI] [HideInInspector] _UseShadowThreshold ("Boolean", Float) = 1
			[ToggleUI] [HideInInspector] _DoubleSidedEnable ("Boolean", Float) = 1
			[Enum(Flip, 0, Mirror, 1, None, 2)] [HideInInspector] _DoubleSidedNormalMode ("Float", Float) = 2
			[HideInInspector] _DoubleSidedConstants ("Vector4", Vector) = (1,1,-1,0)
			[Enum(Auto, 0, On, 1, Off, 2)] [HideInInspector] _DoubleSidedGIMode ("Float", Float) = 0
			[ToggleUI] [HideInInspector] _TransparentDepthPrepassEnable ("Boolean", Float) = 1
			[ToggleUI] [HideInInspector] _TransparentDepthPostpassEnable ("Boolean", Float) = 1
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
			[ToggleUI] [HideInInspector] _EnableFogOnTransparent ("Boolean", Float) = 1
			[HideInInspector] _CullModeForward ("Float", Float) = 2
			[Enum(Front, 1, Back, 2)] [HideInInspector] _TransparentCullMode ("Float", Float) = 2
			[Enum(UnityEngine.Rendering.HighDefinition.OpaqueCullMode)] [HideInInspector] _OpaqueCullMode ("Float", Float) = 2
			[HideInInspector] _ZTestDepthEqualForOpaque ("Float", Float) = 4
			[Enum(UnityEngine.Rendering.CompareFunction)] [HideInInspector] _ZTestTransparent ("Float", Float) = 4
			[ToggleUI] [HideInInspector] _TransparentBackfaceEnable ("Boolean", Float) = 1
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
			[HideInInspector] _StencilWriteMaskMV ("Float", Float) = 43
			[HideInInspector] _StencilRefDistortionVec ("Float", Float) = 4
			[HideInInspector] _StencilWriteMaskDistortionVec ("Float", Float) = 4
			[HideInInspector] [NoScaleOffset] unity_Lightmaps ("unity_Lightmaps", 2DArray) = "" {}
			[HideInInspector] [NoScaleOffset] unity_LightmapsInd ("unity_LightmapsInd", 2DArray) = "" {}
			[HideInInspector] [NoScaleOffset] unity_ShadowMasks ("unity_ShadowMasks", 2DArray) = "" {}
		}
	// Decompiled program was unusable (vertex/fragment variants split); kept as a fallback shell.
	Fallback "HDRP/Lit"
}
