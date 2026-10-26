using System;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.Scp106;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class Ghostly : StatusEffectBase, IFpcCollisionModifier
	{
		public LayerMask DetectionMask => Scp106MovementModule.PassableDetectionMask;

		public override EffectClassification Classification => EffectClassification.Positive;

		public void ProcessColliders(ArraySegment<Collider> detections)
		{
			foreach (Collider item in detections)
			{
				Scp106MovementModule.GetSlowdownFromCollider(item, out var isPassable);
				item.enabled = !isPassable;
			}
		}

		protected override void Enabled()
		{
			base.Enabled();
			if (base.Hub.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				FpcCollisionProcessor.AddModifier(this, fpcRole);
			}
		}

		protected override void Disabled()
		{
			base.Disabled();
			FpcCollisionProcessor.RemoveModifier(this);
		}
	}
}
