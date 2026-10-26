using CustomPlayerEffects;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class A7BurnEffectModule : ModuleBase
	{
		[SerializeField]
		private int _maxDuration;

		[SerializeField]
		private int _perShotDuration;

		[SerializeField]
		private float _forwardOffset;

		[SerializeField]
		private float _radius;

		protected override void OnInit()
		{
			base.OnInit();
			if (base.Firearm.TryGetModule<IHitregModule>(out var module))
			{
				module.ServerOnFired += OnFired;
			}
		}

		private void OnFired()
		{
			ReferenceHub owner = base.Firearm.Owner;
			Vector3 position = owner.transform.position;
			Vector3 forward = owner.PlayerCameraReference.forward;
			Vector3 vector = position + forward * _forwardOffset;
			float num = _radius * _radius;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is IFpcRole fpcRole && HitboxIdentity.IsDamageable(owner, allHub) && !((vector - fpcRole.FpcModule.Position).sqrMagnitude > num) && allHub.playerEffectsController.TryGetEffect<Burned>(out var playerEffect))
				{
					float num2 = Mathf.Min(_perShotDuration, (float)_maxDuration - playerEffect.TimeLeft);
					if (!(num2 <= 0f))
					{
						playerEffect.IsEnabled = true;
						playerEffect.ServerChangeDuration(num2, addDuration: true);
					}
				}
			}
		}
	}
}
