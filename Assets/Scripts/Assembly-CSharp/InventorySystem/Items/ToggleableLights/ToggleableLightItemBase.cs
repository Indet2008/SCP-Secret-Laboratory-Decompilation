using System;
using AudioPooling;
using InventorySystem.GUI;
using Mirror;
using UnityEngine;
using Utils.Networking;

namespace InventorySystem.Items.ToggleableLights
{
	public abstract class ToggleableLightItemBase : ItemBase, IItemDescription, IItemNametag, ILightEmittingItem
	{
		protected const float ToggleCooldownTime = 0.13f;

		protected const float EquipCooldownTime = 0.6f;

		private bool _isEmitting;

		[NonSerialized]
		public float NextAllowedTime;

		public AudioClip OnClip;

		public AudioClip OffClip;

		private static readonly ActionName[] ToggleKeys = new ActionName[3]
		{
			ActionName.Shoot,
			ActionName.Zoom,
			ActionName.ToggleFlashlight
		};

		public override float Weight => 0.7f;

		public string Name => ItemTypeId.GetName();

		public string Description => ItemTypeId.GetDescription();

		public virtual bool IsEmittingLight
		{
			get
			{
				return _isEmitting;
			}
			set
			{
				if (_isEmitting != value)
				{
					_isEmitting = value;
					if (IsLocalPlayer)
					{
						SetLightSourceStatus(value);
						AudioSourcePoolManager.Play2D(value ? OnClip : OffClip);
					}
				}
			}
		}

		protected abstract void SetLightSourceStatus(bool value);

		public override void OnEquipped()
		{
			ForceEnable();
			if (NetworkServer.active)
			{
				new FlashlightNetworkHandler.FlashlightMessage(base.ItemSerial, IsEmittingLight).SendToAuthenticated();
			}
		}

		private void ForceEnable()
		{
			NextAllowedTime = Time.timeSinceLevelLoad + 0.6f;
			IsEmittingLight = true;
		}

		public override void EquipUpdate()
		{
			if (!IsLocalPlayer || !InventoryGuiController.ItemsSafeForInteraction || Time.timeSinceLevelLoad < NextAllowedTime)
			{
				return;
			}
			ActionName[] toggleKeys = ToggleKeys;
			for (int i = 0; i < toggleKeys.Length; i++)
			{
				if (Input.GetKeyDown(NewInput.GetKey(toggleKeys[i])))
				{
					OnToggled();
				}
			}
		}

		protected virtual void OnToggled()
		{
		}

		public void ClientSendRequest(bool value)
		{
			if (IsLocalPlayer && value != IsEmittingLight)
			{
				IsEmittingLight = value;
				NetworkClient.Send(new FlashlightNetworkHandler.FlashlightMessage(base.ItemSerial, value));
			}
		}
	}
}
