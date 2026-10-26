using Mirror;
using UnityEngine;

namespace Hints
{
	public class OutlineEffect : HintEffect
	{
		protected Color32 OutlineColor { get; private set; }

		protected float OutlineWidth { get; private set; }

		public static OutlineEffect FromNetwork(NetworkReader reader)
		{
			OutlineEffect outlineEffect = new OutlineEffect();
			outlineEffect.Deserialize(reader);
			return outlineEffect;
		}

		private OutlineEffect()
		{
		}

		public OutlineEffect(Color32 outlineColor, float outlineWidth, float startScalar = 0f, float durationScalar = 1f)
			: base(startScalar, durationScalar)
		{
			OutlineColor = outlineColor;
			OutlineWidth = outlineWidth;
		}

		public override void Deserialize(NetworkReader reader)
		{
			base.Deserialize(reader);
			OutlineColor = reader.ReadColor32();
			OutlineWidth = reader.ReadFloat();
		}

		public override void Serialize(NetworkWriter writer)
		{
			base.Serialize(writer);
			writer.WriteColor32(OutlineColor);
			writer.WriteFloat(OutlineWidth);
		}
	}
}
