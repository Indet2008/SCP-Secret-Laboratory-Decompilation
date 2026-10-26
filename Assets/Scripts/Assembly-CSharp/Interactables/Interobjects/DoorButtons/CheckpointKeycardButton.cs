using Interactables.Interobjects.DoorUtils;
using UnityEngine;

namespace Interactables.Interobjects.DoorButtons
{
	public class CheckpointKeycardButton : KeycardButton
	{
		[SerializeField]
		private Material _openMaterial;

		[SerializeField]
		private Material _warningMaterial;

		[SerializeField]
		private GameObject _regularScreen;

		[SerializeField]
		private GameObject _passScreen;

		[SerializeField]
		private GameObject _warningScreen;

		private bool _isIdle;

		public override void Init(DoorVariant door)
		{
			base.Init(door);
			if (!(door is CheckpointDoor checkpointDoor))
			{
				Debug.LogError(base.name + " couldn't successfully attach to a CheckpointDoor.", this);
			}
			else
			{
				checkpointDoor.OnSequenceChanged += UpdateSequence;
			}
		}

		private void UpdateSequence()
		{
			if (_isIdle)
			{
				CheckpointDoor.SequenceState curSequence = (base.ParentDoor as CheckpointDoor).CurSequence;
				_passScreen.SetActive(curSequence == CheckpointDoor.SequenceState.OpenLoop);
				_warningScreen.SetActive(curSequence == CheckpointDoor.SequenceState.ClosingWarning);
				if (curSequence == CheckpointDoor.SequenceState.ClosingWarning)
				{
					base.NfcScannerIcon.SetMaterial(_warningMaterial, null);
				}
			}
		}

		private void RestoreScreen()
		{
			_isIdle = false;
			_regularScreen.SetActive(value: true);
			_passScreen.SetActive(value: false);
			_warningScreen.SetActive(value: false);
		}

		protected override void OnDenied(DoorPermissionFlags flags)
		{
			base.OnDenied(flags);
			RestoreScreen();
		}

		protected override void SetAsDestroyed()
		{
			base.SetAsDestroyed();
			RestoreScreen();
		}

		protected override void SetLocked()
		{
			base.SetLocked();
			RestoreScreen();
		}

		protected override void SetIdle()
		{
			base.SetIdle();
			if (base.ParentDoor.TargetState)
			{
				_isIdle = true;
				_regularScreen.SetActive(value: false);
				base.NfcScannerIcon.SetMaterial(_openMaterial, null);
				UpdateSequence();
			}
		}

		protected override void RestoreNonDestroyed()
		{
			base.RestoreNonDestroyed();
			RestoreScreen();
		}

		protected override void SetMoving()
		{
			base.SetMoving();
			if (!base.ParentDoor.TargetState)
			{
				base.NfcScannerIcon.SetRegular();
				base.PermsIndicator.ShowIdle();
			}
			RestoreScreen();
		}
	}
}
