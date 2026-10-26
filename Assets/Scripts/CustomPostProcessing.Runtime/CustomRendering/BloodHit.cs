using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	[Serializable]
	[VolumeComponentMenu("Post-processing/Custom/Blood Hit")]
	public sealed class BloodHit : MaterialEffect
	{
		public ClampedFloatParameter Hit_Left = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Hit_Up = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Hit_Right = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Hit_Down = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Blood_Hit_Left = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Blood_Hit_Up = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Blood_Hit_Right = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Blood_Hit_Down = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Hit_Full = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Blood_Hit_Full_1 = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Blood_Hit_Full_2 = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter Blood_Hit_Full_3 = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter LightReflect = new ClampedFloatParameter(0f, 0f, 1f);

		public TextureParameter BloodHitTexture = new TextureParameter(null);

		protected override string EffectShaderName => "Hidden/Shader/BloodHit";

		public override bool IsActive()
		{
			return BloodHitTexture.value != null && (Hit_Left.value + Hit_Up.value + Hit_Right.value + Hit_Down.value + Blood_Hit_Left.value + Blood_Hit_Up.value + Blood_Hit_Right.value + Blood_Hit_Down.value + Hit_Full.value + Blood_Hit_Full_1.value + Blood_Hit_Full_2.value + Blood_Hit_Full_3.value) > 0f;
		}

		protected override void SetProperties(Material material, HDCamera camera)
		{
			material.SetFloat("_LightReflect", LightReflect.value);
			material.SetVector("_Hits", new Vector4(Hit_Left.value, Hit_Up.value, Hit_Right.value, Hit_Down.value));
			material.SetVector("_BloodHits", new Vector4(Blood_Hit_Left.value, Blood_Hit_Up.value, Blood_Hit_Right.value, Blood_Hit_Down.value));
			material.SetVector("_FullHits", new Vector4(Hit_Full.value, Blood_Hit_Full_1.value, Blood_Hit_Full_2.value, Blood_Hit_Full_3.value));
			material.SetTexture("_BloodTex", BloodHitTexture.value);
		}
	}
}