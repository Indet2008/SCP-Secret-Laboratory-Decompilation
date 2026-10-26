using System;
using CustomPlayerEffects;
using UnityEngine;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class ThrowableItemViewmodel : StandardAnimatedViemodel
	{
		private static readonly int AimHash = Animator.StringToHash("Aim");

		private static readonly int ThrowWeakHash = Animator.StringToHash("ThrowWeak");

		private static readonly int ThrowFullHash = Animator.StringToHash("ThrowFull");

		private static readonly int GrenadeModifier = Animator.StringToHash("SpeedModifier");

		public override void InitLocal(ItemBase ib)
		{
			base.InitLocal(ib);
			((ib as ThrowableItem) ?? throw new InvalidOperationException(string.Format("Item {0} is not a valid target for {1}", ib.ItemTypeId, "ThrowableItemViewmodel"))).OnRequestSent += ProcessAnim;
		}

		public override void InitSpectator(ReferenceHub ply, ItemIdentifier id, bool wasEquipped)
		{
			base.InitSpectator(ply, id, wasEquipped);
			ThrowableNetworkHandler.OnAudioMessageReceived += OnMsgReceived;
			OnEquipped();
			if (!wasEquipped)
			{
				return;
			}
			if (TryGetComponent<AudioSource>(out var component))
			{
				component.Stop();
			}
			if (!ThrowableNetworkHandler.ReceivedRequests.TryGetValue(id.SerialNumber, out var value))
			{
				AnimatorForceUpdate(base.SkipEquipTime);
				return;
			}
			float deltaTime = Mathf.Min(Time.timeSinceLevelLoad - value.Time, base.SkipEquipTime);
			if (value.Request == ThrowableNetworkHandler.RequestType.CancelThrow)
			{
				ProcessAnim(ThrowableNetworkHandler.RequestType.BeginThrow);
				AnimatorForceUpdate(base.SkipEquipTime, fastMode: false);
			}
			ProcessAnim(value.Request);
			AnimatorForceUpdate(deltaTime, fastMode: false);
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			AnimatorSetFloat(GrenadeModifier, base.ItemId.TypeId.GetSpeedMultiplier(base.Hub));
		}

		private void OnDestroy()
		{
			if (base.IsSpectator)
			{
				ThrowableNetworkHandler.OnAudioMessageReceived -= OnMsgReceived;
			}
			else
			{
				(base.ParentItem as ThrowableItem).OnRequestSent -= ProcessAnim;
			}
		}

		private void ProcessAnim(ThrowableNetworkHandler.RequestType request)
		{
			switch (request)
			{
			case ThrowableNetworkHandler.RequestType.BeginThrow:
				AnimatorSetBool(AimHash, val: true);
				break;
			case ThrowableNetworkHandler.RequestType.CancelThrow:
				AnimatorSetBool(AimHash, val: false);
				break;
			case ThrowableNetworkHandler.RequestType.ConfirmThrowFullForce:
				AnimatorSetBool(AimHash, val: true);
				AnimatorSetTrigger(ThrowFullHash);
				break;
			case ThrowableNetworkHandler.RequestType.ConfirmThrowWeak:
				AnimatorSetBool(AimHash, val: true);
				AnimatorSetTrigger(ThrowWeakHash);
				break;
			}
		}

		private void OnMsgReceived(ThrowableNetworkHandler.ThrowableItemAudioMessage msg)
		{
			if (msg.Serial == base.ItemId.SerialNumber)
			{
				ProcessAnim(msg.Request);
			}
		}
	}
}
