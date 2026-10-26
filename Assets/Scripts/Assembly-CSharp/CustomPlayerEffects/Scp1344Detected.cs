using System.Collections.Generic;
using AudioPooling;
using InventorySystem.Items.Usables.Scp1344;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using RemoteAdmin.Interfaces;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class Scp1344Detected : StatusEffectBase, ICustomDisplayName
	{
		private readonly List<Scp1344HumanXrayProvider> _seenBy = new List<Scp1344HumanXrayProvider>();

		private float _remainingReEnableCooldown;

		[SerializeField]
		private AudioClip _detectedClip;

		[SerializeField]
		private float _reEnableCooldown;

		public string DisplayName => null;

		public bool CanBeDisplayed => false;

		public void ServerRegisterObserver(Scp1344HumanXrayProvider source)
		{
			if (!_seenBy.Contains(source) && ValidateObserver(source))
			{
				_seenBy.Add(source);
				UpdateStatus();
				PlayerEvents.OnDetectedByScp1344(new PlayerDetectedByScp1344EventArgs(source.Hub, base.Hub));
			}
		}

		protected override void Enabled()
		{
			base.Enabled();
			if (base.IsPOV && !(_remainingReEnableCooldown > 0f))
			{
				AudioSourcePoolManager.Play2D(_detectedClip, 1f, MixerChannel.NoDucking);
			}
		}

		protected override void Disabled()
		{
			base.Disabled();
			_seenBy.Clear();
			_remainingReEnableCooldown = _reEnableCooldown;
		}

		protected override void OnEffectUpdate()
		{
			base.OnEffectUpdate();
			UpdateStatus();
		}

		protected override void Update()
		{
			base.Update();
			if (_remainingReEnableCooldown > 0f)
			{
				_remainingReEnableCooldown -= Time.deltaTime;
			}
		}

		private bool ValidateObserver(Scp1344HumanXrayProvider source)
		{
			if (source != null && HitboxIdentity.IsEnemy(source.Hub, base.Hub))
			{
				return source.GetVisibilityForTarget(base.Hub);
			}
			return false;
		}

		private void UpdateStatus()
		{
			if (!NetworkServer.active)
			{
				return;
			}
			for (int num = _seenBy.Count - 1; num >= 0; num--)
			{
				if (!ValidateObserver(_seenBy[num]))
				{
					_seenBy.RemoveAt(num);
				}
			}
			base.IsEnabled = _seenBy.Count > 0;
		}
	}
}
