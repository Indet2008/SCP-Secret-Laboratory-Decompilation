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

		public void ExecutePulse()
		{
		}

		private void ServerSendPulse()
		{
			base.Hub.playerEffectsController.ServerSendPulse<AmnesiaItems>();
		}
	}
}
