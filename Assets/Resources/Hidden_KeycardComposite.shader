// Stand-in for the "Shader Graphs/KeycardTint" graph, which did not survive the decompile.
// KeycardMaterialHandler blits the card albedo through this shader into a texture that HDRP/Lit
// then uses as its base color map: the mask's blue channel takes the tint, and the 3x3 permission
// dots (blue = containment, green = armory, red = admin) are filled up to each access level.
Shader "Hidden/KeycardComposite"
{
	Properties
	{
		_MainTex ("Albedo", 2D) = "white" {}
		_Mask ("Mask", 2D) = "black" {}
		_PermsMask ("PermsMask", 2D) = "white" {}
		_Tint ("Tint", Color) = (1,1,1,1)
		_PermsColor ("PermsColor", Color) = (0,0,0,1)
		_PermsMapTilling ("PermsMapTilling", Vector) = (1,1,0,0)
		_PermsMapOffset ("PermsMapOffset", Vector) = (0,0,0,0)
		_PermsRotation ("PermsRotation", Float) = 0
		_ContainmentStep ("ContainmentStep", Float) = 1
		_ArmoryStep ("ArmoryStep", Float) = 1
		_AdminStep ("AdminStep", Float) = 1
	}
	SubShader
	{
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			sampler2D _Mask;
			sampler2D _PermsMask;
			float4 _Tint;
			float4 _PermsColor;
			float4 _PermsMapTilling;
			float4 _PermsMapOffset;
			float _PermsRotation;
			float _ContainmentStep;
			float _ArmoryStep;
			float _AdminStep;

			// Shader Graph's Rotate node (degrees) around the UV center.
			float2 RotateDegrees(float2 uv, float degrees)
			{
				float r = radians(degrees);
				float s = sin(r);
				float c = cos(r);
				uv -= 0.5;
				uv = float2(uv.x * c + uv.y * s, -uv.x * s + uv.y * c);
				return uv + 0.5;
			}

			fixed4 frag(v2f_img i) : SV_Target
			{
				float4 albedo = tex2D(_MainTex, i.uv);
				float tintMask = tex2D(_Mask, i.uv).b;
				float3 col = lerp(albedo.rgb, albedo.rgb * _Tint.rgb, tintMask);

				// Permission dots exactly as the original KeycardTint graph (decompiled GBuffer program):
				// R = containment, G = armory, B = admin thresholds, A = dot coverage. A dot is filled unless
				// all three steps are at or above its thresholds.
				float2 permsUv = RotateDegrees(i.uv, _PermsRotation) * _PermsMapTilling.xy + _PermsMapOffset.xy;
				float4 perms = tex2D(_PermsMask, permsUv);
				float empty = step(perms.r, _ContainmentStep) * step(perms.b, _AdminStep) * step(perms.g, _ArmoryStep);
				// The original samples with a clamping sampler, so the grid appears once; outside it nothing is drawn.
				float inside = step(0.0, permsUv.x) * step(permsUv.x, 1.0) * step(0.0, permsUv.y) * step(permsUv.y, 1.0);
				float fill = perms.a * (1.0 - empty) * inside;
				col = lerp(col, _PermsColor.rgb, fill);
				return fixed4(col, albedo.a);
			}
			ENDCG
		}
	}
}
