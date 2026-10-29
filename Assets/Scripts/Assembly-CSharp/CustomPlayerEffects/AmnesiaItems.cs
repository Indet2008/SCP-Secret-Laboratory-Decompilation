using InventorySystem.Items.Firearms.Attachments;
using Mirror;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class AmnesiaItems : StatusEffectBase, IUsableItemModifierEffect, IWeaponModifierPlayerEffect, IPulseEffect
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private float _pulseMax;

		[global::UnityEngine.SerializeField]
		private float _vignetteLerp;

		[global::UnityEngine.SerializeField]
		private float _pulseDrop;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AnimationCurve _pulseMinOverTime;


		private float _activeTime;

		[SerializeField]
		private ItemType[] _blockedUsableItems;

		[SerializeField]
		private float _blockDelay;

		public bool ParamsActive
		{
			get
			{
				if (base.IsEnabled)
				{
					return _activeTime >= _blockDelay;
				}
				return false;
			}
		}

		protected override void Update()
		{
			base.Update();
			if (base.IsEnabled)
			{
				_activeTime += Time.deltaTime;
			}
		}

		protected override void Enabled()
		{
			base.Enabled();
			_activeTime = 0f;
		}

		public bool TryGetSpeed(ItemType item, out float speed)
		{
			speed = 0f;
			if (!NetworkServer.active || !_blockedUsableItems.Contains(item) || _activeTime < _blockDelay)
			{
				return false;
			}
			ServerSendPulse();
			return true;
		}

		public bool TryGetWeaponParam(AttachmentParam param, out float val)
		{
			val = 1f;
			if (!NetworkServer.active || param != AttachmentParam.PreventReload || _activeTime < _blockDelay)
			{
				return false;
			}
			ServerSendPulse();
			return true;
		}

		// Client half restored from the client build (IL2CPP): a vignette that pulses when an item use is blocked
		// and otherwise settles to a minimum that grows over time.
		private global::UnityEngine.Rendering.HighDefinition.Vignette _vignette;

		private float _pulseTarget;

		protected override void Awake()
		{
			base.Awake();
			global::UnityEngine.Rendering.Volume volume = GetComponent<global::UnityEngine.Rendering.Volume>();
			if (volume != null && volume.profile != null)
			{
				volume.profile.TryGet(out _vignette);
			}
		}

		protected override void OnEffectUpdate()
		{
			base.OnEffectUpdate();
			if (_vignette == null || !IsPOV)
			{
				return;
			}
			float current = _vignette.intensity.value;
			_vignette.intensity.Override(Mathf.Lerp(current, _pulseTarget, Time.deltaTime * _vignetteLerp));
			float min = _pulseMinOverTime.Evaluate(_activeTime);
			_pulseTarget = Mathf.Max(min, _pulseTarget - Time.deltaTime * _pulseDrop);
		}

		protected override void Disabled()
		{
			base.Disabled();
			_pulseTarget = 0f;
			if (_vignette != null)
			{
				_vignette.intensity.Override(0f);
			}
		}

		public void ExecutePulse()
		{
			_pulseTarget = _pulseMax;
		}

		private void ServerSendPulse()
		{
			base.Hub.playerEffectsController.ServerSendPulse<AmnesiaItems>();
		}
	}
}
