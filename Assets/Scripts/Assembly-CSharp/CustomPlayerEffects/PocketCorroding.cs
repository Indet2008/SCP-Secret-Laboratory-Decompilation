using AudioPooling;
using CustomRendering;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using MapGeneration;
using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerStatsSystem;
using RelativePositioning;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class PocketCorroding : TickingEffectBase, IFootstepEffect, IMovementSpeedModifier, IStaminaModifier
	{
		private const float DamageScaling = 0.15f;

		private const float PDSpawnHeightOffset = 1.5f;

		private const byte NonTeleportIntensity = 106;

		[SerializeField]
		private float _startingDamage = 1f;

		[SerializeField]
		private AudioClip[] _footstepSounds;

		[SerializeField]
		private float _originalLoudness;

		private float _damagePerTick = 1f;

		public override bool AllowEnabling => true;

		public bool MovementModifierActive => base.IsEnabled;

		public bool StaminaModifierActive => base.IsEnabled;

		public float StaminaUsageMultiplier => 1f;

		public float MovementSpeedMultiplier => 0.75f;

		public float StaminaRegenMultiplier => 1f;

		public bool SprintingDisabled => true;

		public float MovementSpeedLimit => float.MaxValue;

		public RelativePosition CapturePosition { get; private set; }

		protected override void OnTick()
		{
			if (NetworkServer.active)
			{
				if (base.Hub.TryGetLastKnownRoom(out var room) && room.Name == RoomName.Pocket)
				{
					base.Hub.playerStats.DealDamage(new UniversalDamageHandler(_damagePerTick, DeathTranslations.PocketDecay));
					_damagePerTick += 0.15f;
				}
				else
				{
					ServerDisable();
				}
			}
		}

		protected override void Enabled()
		{
			if (base.IsPOV)
			{
				SetFogEnabled(isEnabled: true);
			}
			if (!NetworkServer.active)
			{
				return;
			}
			_damagePerTick = _startingDamage;
			if (!(base.Hub.roleManager.CurrentRole is IFpcRole fpcRole) || !RoomUtils.TryFindRoom(RoomName.Pocket, null, null, out var foundRoom))
			{
				return;
			}
			PlayerEnteringPocketDimensionEventArgs e = new PlayerEnteringPocketDimensionEventArgs(base.Hub);
			PlayerEvents.OnEnteringPocketDimension(e);
			if (e.IsAllowed)
			{
				CapturePosition = new RelativePosition(fpcRole.FpcModule.Position);
				if (base.Intensity < 106)
				{
					Vector3 position = foundRoom.transform.position;
					Vector3 vector = Vector3.up * 1.5f;
					fpcRole.FpcModule.ServerOverridePosition(position + vector);
				}
				PlayerEvents.OnEnteredPocketDimension(new PlayerEnteredPocketDimensionEventArgs(base.Hub));
			}
		}

		protected override void Disabled()
		{
			base.Disabled();
			if (base.IsPOV)
			{
				SetFogEnabled(isEnabled: false);
			}
		}

		public override void OnBeginSpectating()
		{
			base.OnBeginSpectating();
			SetFogEnabled(base.IsEnabled);
		}

		public override void OnStopSpectating()
		{
			base.OnStopSpectating();
			SetFogEnabled(isEnabled: false);
		}

		public float ProcessFootstepOverrides(AnimatedCharacterModel _, float dis)
		{
			AudioSourcePoolManager.PlayOnTransform(_footstepSounds.RandomItem(), base.transform, dis);
			return _originalLoudness;
		}

		private void SetFogEnabled(bool isEnabled)
		{
			if (isEnabled)
			{
				FogController.EnableFogType(FogType.PocketDimension);
			}
			else
			{
				FogController.DisableFogType(FogType.PocketDimension);
			}
		}

		public void ServerOverrideCapturePosition(RelativePosition capturePosition)
		{
			CapturePosition = capturePosition;
		}

		internal override void OnRoleChanged(PlayerRoleBase previousRole, PlayerRoleBase newRole)
		{
			base.OnRoleChanged(previousRole, newRole);
			if (NetworkServer.active && newRole is IFpcRole fpcRole && fpcRole.FpcModule.Position.TryGetRoom(out var room) && room.Name == RoomName.Pocket)
			{
				ServerSetState(106);
			}
		}
	}
}
