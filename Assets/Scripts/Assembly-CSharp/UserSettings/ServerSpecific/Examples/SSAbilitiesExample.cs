using System.Collections.Generic;
using CustomPlayerEffects;
using InventorySystem;
using InventorySystem.Items;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;
using UnityEngine;

namespace UserSettings.ServerSpecific.Examples
{
	public class SSAbilitiesExample : SSExampleImplementationBase
	{
		private enum ExampleId
		{
			SpeedBoostKey = 0,
			SpeedBoostToggle = 1,
			HealAlly = 2
		}

		private const float HealAllyHp = 50f;

		private const float HealAllyRange = 3.5f;

		private const byte BoostIntensity = 60;

		private const float BoostHealthDrain = 5f;

		private static HashSet<ReferenceHub> _activeSpeedBoosts;

		public override string Name => "Abilities Extension";

		public override void Activate()
		{
			_activeSpeedBoosts = new HashSet<ReferenceHub>();
			ServerSpecificSettingsSync.DefinedSettings = new ServerSpecificSettingBase[4]
			{
				new SSGroupHeader("Abilities"),
				new SSKeybindSetting(2, "Heal Ally", KeyCode.H, preventInteractionOnGui: true, allowSpectatorTrigger: true, $"Press this key while holding a medkit to instantly heal a stationary ally for {50f} HP."),
				new SSKeybindSetting(0, "Speed Boost (Human-only)", KeyCode.Y, preventInteractionOnGui: true, allowSpectatorTrigger: true, "Increase your speed by draining your health."),
				new SSTwoButtonsSetting(1, "Speed Boost - Activation Mode", "Hold", "Toggle")
			};
			ServerSpecificSettingsSync.SendToAll();
			ServerSpecificSettingsSync.ServerOnSettingValueReceived += ProcessUserInput;
			ReferenceHub.OnPlayerRemoved += OnPlayerDisconnected;
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
			StaticUnityMethods.OnUpdate += OnUpdate;
		}

		public override void Deactivate()
		{
			ServerSpecificSettingsSync.ServerOnSettingValueReceived -= ProcessUserInput;
			ReferenceHub.OnPlayerRemoved -= OnPlayerDisconnected;
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
			StaticUnityMethods.OnUpdate -= OnUpdate;
		}

		private void ProcessUserInput(ReferenceHub sender, ServerSpecificSettingBase setting)
		{
			switch ((ExampleId)setting.SettingId)
			{
			case ExampleId.HealAlly:
				if (setting is SSKeybindSetting { SyncIsPressed: not false })
				{
					TryHealAlly(sender);
				}
				break;
			case ExampleId.SpeedBoostKey:
				if (!(setting is SSKeybindSetting sSKeybindSetting))
				{
					break;
				}
				if (ServerSpecificSettingsSync.GetSettingOfUser<SSTwoButtonsSetting>(sender, 1).SyncIsB)
				{
					if (sSKeybindSetting.SyncIsPressed)
					{
						SetSpeedBoost(sender, !_activeSpeedBoosts.Contains(sender));
					}
				}
				else
				{
					SetSpeedBoost(sender, sSKeybindSetting.SyncIsPressed);
				}
				break;
			case ExampleId.SpeedBoostToggle:
				SetSpeedBoost(sender, state: false);
				break;
			}
		}

		private void TryHealAlly(ReferenceHub sender)
		{
			ItemIdentifier curItem = sender.inventory.CurItem;
			if (curItem.TypeId != ItemType.Medkit)
			{
				return;
			}
			Vector3 position = sender.PlayerCameraReference.position;
			Vector3 forward = sender.PlayerCameraReference.forward;
			HitboxIdentity component;
			while (true)
			{
				if (!Physics.Raycast(position, forward, out var hitInfo, 3.5f) || !hitInfo.collider.TryGetComponent<HitboxIdentity>(out component) || HitboxIdentity.IsEnemy(component.TargetHub, sender))
				{
					return;
				}
				if (!(component.TargetHub == sender))
				{
					break;
				}
				position += forward * 0.08f;
			}
			ReferenceHub targetHub = component.TargetHub;
			targetHub.playerStats.GetModule<HealthStat>().ServerHeal(50f);
			sender.inventory.ServerRemoveItem(curItem.SerialNumber, null);
		}

		private void SetSpeedBoost(ReferenceHub hub, bool state)
		{
			MovementBoost effect = hub.playerEffectsController.GetEffect<MovementBoost>();
			if (state && hub.IsHuman())
			{
				effect.ServerSetState(60);
				_activeSpeedBoosts.Add(hub);
			}
			else
			{
				effect.ServerDisable();
				_activeSpeedBoosts.Remove(hub);
			}
		}

		private void OnPlayerDisconnected(ReferenceHub hub)
		{
			_activeSpeedBoosts.Remove(hub);
		}

		private void OnRoleChanged(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			SetSpeedBoost(userHub, state: false);
		}

		private void OnUpdate()
		{
			if (!StaticUnityMethods.IsPlaying)
			{
				return;
			}
			foreach (ReferenceHub activeSpeedBoost in _activeSpeedBoosts)
			{
				if (!Mathf.Approximately(activeSpeedBoost.GetVelocity().SqrMagnitudeIgnoreY(), 0f))
				{
					activeSpeedBoost.playerStats.DealDamage(new UniversalDamageHandler(Time.deltaTime * 5f, DeathTranslations.Scp207));
				}
			}
		}
	}
}
