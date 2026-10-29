using InventorySystem;
using InventorySystem.Items;
using PlayerRoles.PlayableScps.HUDs;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp3114
{
	// Restored from the client build (IL2CPP).
	public class Scp3114Hud : ViewmodelScpHud
	{
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _hudRoot;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.ScpWarningHud _warning;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.AbilityHud _strangleCooldown;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.AbilityHud _strangleTimer;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.AbilityHud _identityCooldown;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.LoadingCircleHud _stealSkinBar;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.RawImage _avatarImage;

		private Scp3114Strangle _strangle;

		private Scp3114Identity _identity;

		private Scp3114Disguise _disguise;

		private Scp3114Role _scpRole;

		private bool _wasLocalPlayer;

		private Scp3114VoiceModule _voiceModule;

		internal override void Init(ReferenceHub hub)
		{
			base.Init(hub);
			_scpRole = hub.roleManager.CurrentRole as Scp3114Role;
			_scpRole.SubroutineModule.TryGetSubroutine(out _strangle);
			_scpRole.SubroutineModule.TryGetSubroutine(out _identity);
			_scpRole.SubroutineModule.TryGetSubroutine(out _disguise);
			_strangleCooldown.Setup(_strangle.Cooldown, null);
			_strangleTimer.Setup(_strangle.StrangleTimer, null);
			_identityCooldown.Setup(_disguise.Cooldown, _identity.RemainingDuration);
			if (!hub.isLocalPlayer)
			{
				return;
			}
			_wasLocalPlayer = true;
			_identity.CurIdentity.OnStatusChanged += OnIdentityChanged;
			_disguise.OnErrorReceived += OnDisguiseErrorReceived;
			_strangle.OnAttemptedWhileDisguised += OnAttackWhileDisguised;
			Inventory.OnCurrentItemChanged += OnCurrentItemChanged;
			Scp3114Reveal.OnRevealFail += OnRevealFail;
			_voiceModule = _scpRole.VoiceModule as Scp3114VoiceModule;
			if (_voiceModule != null)
			{
				_voiceModule.OnHintTriggered += OnVcHintTriggered;
			}
		}

		internal override void OnDied()
		{
			base.OnDied();
			_hudRoot.SetActive(false);
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			if (!_wasLocalPlayer)
			{
				return;
			}
			_identity.CurIdentity.OnStatusChanged -= OnIdentityChanged;
			_disguise.OnErrorReceived -= OnDisguiseErrorReceived;
			_strangle.OnAttemptedWhileDisguised -= OnAttackWhileDisguised;
			Inventory.OnCurrentItemChanged -= OnCurrentItemChanged;
			Scp3114Reveal.OnRevealFail -= OnRevealFail;
			if (_voiceModule != null)
			{
				_voiceModule.OnHintTriggered -= OnVcHintTriggered;
			}
		}

		protected override void Update()
		{
			base.Update();
			_stealSkinBar.Apply(_disguise.ProgressStatus, !_disguise.IsInProgress);
			_strangleCooldown.Update();
			_strangleTimer.Update();
			_identityCooldown.Update();
		}

		private void OnIdentityChanged()
		{
			if (_identity.CurIdentity.Status == Scp3114Identity.DisguiseStatus.Active && _identity.CurIdentity.StolenRole.TryGetRoleTemplate<PlayerRoleBase>(out var role))
			{
				PlayWarning(Scp3114HudTranslation.IdentityStolenWarning, role.GetColoredName());
			}
		}

		private void OnDisguiseErrorReceived(byte errorCode)
		{
			PlayWarning((Scp3114HudTranslation)errorCode);
		}

		private void OnAttackWhileDisguised()
		{
			PlayWarning(Scp3114HudTranslation.UnableToAttackWarning);
		}

		private void OnRevealFail()
		{
			PlayWarning(Scp3114HudTranslation.RevealKeyHoldLongerWarning);
		}

		private void OnVcHintTriggered()
		{
			PlayWarning(Scp3114HudTranslation.ProximityVoiceHint, ActionName.AltVoiceChat);
		}

		private void OnCurrentItemChanged(ReferenceHub ply, ItemIdentifier prevItem, ItemIdentifier newItem)
		{
			if (ply != null && ply.isLocalPlayer && prevItem.TypeId == ItemType.None && newItem.TypeId != ItemType.None)
			{
				PlayWarning(Scp3114HudTranslation.EquipItemWarning);
			}
		}

		private void PlayWarning(Scp3114HudTranslation text)
		{
			_warning.SetText(Translations.TryGet(text, out var tr) ? tr : text.ToString());
		}

		private void PlayWarning(Scp3114HudTranslation text, string formatArg0)
		{
			string format = Translations.TryGet(text, out var tr) ? tr : text.ToString();
			_warning.SetText(string.Format(format, formatArg0));
		}

		private void PlayWarning(Scp3114HudTranslation text, ActionName action)
		{
			PlayWarning(text, new ReadableKeyCode(NewInput.GetKey(action)).ToString());
		}
	}
}
