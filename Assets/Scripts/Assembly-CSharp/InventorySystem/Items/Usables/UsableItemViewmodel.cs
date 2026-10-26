using CustomPlayerEffects;
using UnityEngine;

namespace InventorySystem.Items.Usables
{
	public class UsableItemViewmodel : StandardAnimatedViemodel
	{
		private static readonly int UseAnimHash = Animator.StringToHash("IsUsing");

		private static readonly int SpeedModifierHash = Animator.StringToHash("SpeedModifier");

		[SerializeField]
		private AudioSource _equipSoundSource;

		private float _originalPitch = 1f;

		public override void InitAny()
		{
			base.InitAny();
			if (_equipSoundSource != null)
			{
				_originalPitch = _equipSoundSource.pitch;
			}
		}

		public override void InitSpectator(ReferenceHub ply, ItemIdentifier id, bool wasEquipped)
		{
			base.InitSpectator(ply, id, wasEquipped);
			OnEquipped();
			UsableItemsController.OnClientStatusReceived += HandleMessage;
			if (wasEquipped)
			{
				if (_equipSoundSource != null)
				{
					_equipSoundSource.Stop();
				}
				if (UsableItemsController.StartTimes.TryGetValue(id.SerialNumber, out var value))
				{
					AnimatorSetBool(UseAnimHash, val: true);
					AnimatorForceUpdate(Time.timeSinceLevelLoad - value, fastMode: false);
				}
				else
				{
					AnimatorForceUpdate(base.SkipEquipTime);
				}
			}
		}

		public virtual void OnUsingCancelled()
		{
			AnimatorSetBool(UseAnimHash, val: false);
		}

		public virtual void OnUsingStarted()
		{
			if (_equipSoundSource != null)
			{
				_equipSoundSource.Stop();
			}
			AnimatorSetBool(UseAnimHash, val: true);
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			float speedMultiplier = base.ItemId.TypeId.GetSpeedMultiplier(base.Hub);
			AnimatorSetFloat(SpeedModifierHash, speedMultiplier);
			if (_equipSoundSource != null)
			{
				_equipSoundSource.pitch = _originalPitch * speedMultiplier;
			}
		}

		private void HandleMessage(StatusMessage msg)
		{
			if (msg.ItemSerial == base.ItemId.SerialNumber)
			{
				AnimatorSetBool(UseAnimHash, msg.Status == StatusMessage.StatusType.Start);
			}
		}

		protected virtual void OnDestroy()
		{
			if (base.IsSpectator)
			{
				UsableItemsController.OnClientStatusReceived -= HandleMessage;
			}
		}
	}
}
