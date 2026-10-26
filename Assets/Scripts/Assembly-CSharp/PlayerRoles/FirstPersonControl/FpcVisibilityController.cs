using CustomPlayerEffects;
using MapGeneration;
using PlayerRoles.Visibility;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl
{
	public class FpcVisibilityController : VisibilityController
	{
		private Invisible _invisibleEffect;

		private Scp1344 _scp1344Effect;

		protected virtual int NormalMaxRangeSqr => 1300;

		protected virtual int SurfaceMaxRangeSqr => 4900;

		public override InvisibilityFlags IgnoredFlags
		{
			get
			{
				InvisibilityFlags invisibilityFlags = base.IgnoredFlags;
				if (_scp1344Effect.IsEnabled)
				{
					invisibilityFlags |= (InvisibilityFlags)3u;
				}
				return invisibilityFlags;
			}
		}

		public override InvisibilityFlags GetActiveFlags(ReferenceHub observer)
		{
			InvisibilityFlags invisibilityFlags = base.GetActiveFlags(observer);
			if (_invisibleEffect.IsEnabled)
			{
				invisibilityFlags |= InvisibilityFlags.Scp268;
			}
			if (!(observer.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return invisibilityFlags;
			}
			if (!(base.Owner.roleManager.CurrentRole is IFpcRole fpcRole2))
			{
				return invisibilityFlags;
			}
			Vector3 position = fpcRole.FpcModule.Position;
			Vector3 position2 = fpcRole2.FpcModule.Position;
			float sqrMagnitude = (position - position2).sqrMagnitude;
			float num = ((observer.GetCurrentZone() == FacilityZone.Surface) ? SurfaceMaxRangeSqr : NormalMaxRangeSqr);
			if (sqrMagnitude > num)
			{
				invisibilityFlags |= InvisibilityFlags.OutOfRange;
			}
			return invisibilityFlags;
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			PlayerEffectsController playerEffectsController = base.Owner.playerEffectsController;
			_invisibleEffect = playerEffectsController.GetEffect<Invisible>();
			_scp1344Effect = playerEffectsController.GetEffect<Scp1344>();
		}
	}
}
