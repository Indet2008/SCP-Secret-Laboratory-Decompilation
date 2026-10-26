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
	// Decompiled program was unusable (vertex/fragment variants split); kept as a fallback shell.
	Fallback "HDRP/Lit"
}
