using CustomPlayerEffects;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using MapGeneration;
using PlayerRoles;
using UnityEngine;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class FlashbangGrenade : EffectGrenade
	{
		public LayerMask BlindingMask;

		public float BlindTime;

		[SerializeField]
		private AnimationCurve _blindingOverDistance;

		[SerializeField]
		private AnimationCurve _turnedAwayBlindingDistance;

		[SerializeField]
		private AnimationCurve _blindingOverDot;

		[SerializeField]
		private AnimationCurve _deafenDurationOverDistance;

		[SerializeField]
		private AnimationCurve _turnedAwayDeafenDurationOverDistance;

		[SerializeField]
		private AnimationCurve _shakeOverDistance;

		[SerializeField]
		private float _surfaceZoneDistanceIntensifier;

		[SerializeField]
		private float _additionalBlurDuration;

		[SerializeField]
		private float _minimalEffectDuration;

		private int _hitPlayerCount;

		public override void PlayExplosionEffects(Vector3 pos)
		{
			base.PlayExplosionEffects(pos);
			if (MainCameraController.InstanceActive)
			{
				float time = Vector3.Distance(MainCameraController.CurrentCamera.position, pos);
				float explosionForce = _shakeOverDistance.Evaluate(time);
				ExplosionCameraShake.singleton.Shake(explosionForce);
			}
		}

		public override bool ServerFuseEnd()
		{
			if (!base.ServerFuseEnd())
			{
				return false;
			}
			float duration = _blindingOverDistance.GetDuration();
			float num = duration * duration;
			_hitPlayerCount = 0;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (!((base.transform.position - allHub.transform.position).sqrMagnitude > num) && !(allHub == PreviousOwner.Hub) && HitboxIdentity.IsDamageable(PreviousOwner.Role, allHub.GetRoleId()))
				{
					ProcessPlayer(allHub);
				}
			}
			if (_hitPlayerCount > 0)
			{
				Hitmarker.SendHitmarkerDirectly(PreviousOwner.Hub, _hitPlayerCount);
			}
			ServerEvents.OnProjectileExploded(new ProjectileExplodedEventArgs(this, PreviousOwner.Hub, base.transform.position));
			return true;
		}

		private void ProcessPlayer(ReferenceHub hub)
		{
			if (!Physics.Linecast(base.transform.position, hub.PlayerCameraReference.position, BlindingMask))
			{
				Vector3 vector = base.transform.position - hub.PlayerCameraReference.position;
				float num = vector.magnitude;
				if (hub.GetCurrentZone() == FacilityZone.Surface)
				{
					num /= _surfaceZoneDistanceIntensifier;
				}
				bool num2 = Vector3.Dot(hub.PlayerCameraReference.forward, vector.normalized) >= 0.5f;
				float num3 = (num2 ? _blindingOverDistance.Evaluate(num) : _turnedAwayBlindingDistance.Evaluate(num));
				float num4 = (num2 ? num3 : _turnedAwayDeafenDurationOverDistance.Evaluate(num));
				float num5 = (num2 ? _deafenDurationOverDistance.Evaluate(num) : (num4 * BlindTime));
				if (num5 > _minimalEffectDuration)
				{
					ServerLogs.AddLog(ServerLogs.Modules.Throwable, hub.LoggedNameFromRefHub() + " has been deafened by " + PreviousOwner.LoggedNameFromFootprint() + " using a flashbang grenade.", ServerLogs.ServerLogType.GameEvent);
					hub.playerEffectsController.EnableEffect<Deafened>(num5, addDuration: true);
				}
				if (num3 > _minimalEffectDuration)
				{
					ServerLogs.AddLog(ServerLogs.Modules.Throwable, hub.LoggedNameFromRefHub() + " has been flashed by " + PreviousOwner.LoggedNameFromFootprint() + " using a flashbang grenade.", ServerLogs.ServerLogType.GameEvent);
					_hitPlayerCount++;
					hub.playerEffectsController.EnableEffect<Flashed>(num3 * BlindTime, addDuration: true);
				}
				if (num <= 10f)
				{
					ServerLogs.AddLog(ServerLogs.Modules.Throwable, hub.LoggedNameFromRefHub() + " has been blinded by " + PreviousOwner.LoggedNameFromFootprint() + " using a flashbang grenade.", ServerLogs.ServerLogType.GameEvent);
					hub.playerEffectsController.EnableEffect<Blurred>(num4 * BlindTime + _additionalBlurDuration * num4, addDuration: true);
				}
			}
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
