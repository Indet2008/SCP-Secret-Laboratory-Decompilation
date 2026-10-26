using Interactables.Interobjects.DoorUtils;
using UnityEngine;

namespace Interactables.Interobjects.DoorButtons
{
	public class KeycardButton : BasicDoorButton
	{
		[SerializeField]
		private float _deniedDuration;

		[SerializeField]
		private GameObject _destroyedRoot;

		[SerializeField]
		private GameObject _nonDestroyedRoot;

		[field: SerializeField]
		protected KeycardScannerNfcIcon NfcScannerIcon { get; private set; }

		[field: SerializeField]
		protected KeycardScannerPermsIndicator PermsIndicator { get; private set; }

		public override void Init(DoorVariant door)
		{
			base.Init(door);
			PermsIndicator.Register(door);
		}

		protected override void SetMoving()
		{
			NfcScannerIcon.SetGranted();
			PermsIndicator.PlayAccepted(null);
		}

		protected override void SetAsDestroyed()
		{
			base.SetAsDestroyed();
			_destroyedRoot.SetActive(value: true);
			_nonDestroyedRoot.SetActive(value: false);
			NfcScannerIcon.SetError();
		}

		protected override void RestoreNonDestroyed()
		{
			base.RestoreNonDestroyed();
			_destroyedRoot.SetActive(value: false);
			_nonDestroyedRoot.SetActive(value: true);
		}

		protected override void SetIdle()
		{
			NfcScannerIcon.SetRegular();
			PermsIndicator.ShowIdle();
		}

		protected override void SetLocked()
		{
			NfcScannerIcon.SetError();
			PermsIndicator.ShowIdle();
		}

		protected override void OnDenied(DoorPermissionFlags flags)
		{
			base.OnDenied(flags);
			NfcScannerIcon.SetTemporaryDenied(_deniedDuration);
			PermsIndicator.PlayDenied(flags, _deniedDuration);
		}
	}
}
