using InventorySystem.Items.SwayControllers;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp1344
{
	public class Scp1344Viewmodel : UsableItemViewmodel
	{
		private static readonly FixedSway FixedSway = new FixedSway(null, Vector3.zero, Vector3.zero);

		private static readonly int StatusAnimHash = Animator.StringToHash("CurStatus");

		private static readonly int InspectAnimHash = Animator.StringToHash("Inspect");

		[SerializeField]
		private AudioClip _wearSound;

		[SerializeField]
		private AudioClip _inspectSound;

		[SerializeField]
		private AudioClip _removeBuildUpSound;

		private AudioSource _audioSource;

		private AudioClip _originalClip;

		private float _originalVolume;

		private Scp1344Status _status;

		public override IItemSwayController SwayController
		{
			get
			{
				Scp1344Status status = _status;
				if (status != Scp1344Status.Inspecting && status != Scp1344Status.Idle)
				{
					return FixedSway;
				}
				return base.SwayController;
			}
		}

		public override void InitAny()
		{
			base.InitAny();
			FixedSway.SetTransform(HandsPivot);
			Scp1344NetworkHandler.OnStatusChanged += ClientChangeStatus;
			ClientChangeStatus(base.ItemId.SerialNumber, Scp1344NetworkHandler.GetSavedStatus(base.ItemId.SerialNumber));
		}

		public override void OnUsingStarted()
		{
			base.OnUsingStarted();
			PlayClip(_wearSound);
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			Scp1344NetworkHandler.OnStatusChanged -= ClientChangeStatus;
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			if (!base.IsSpectator)
			{
				ClientChangeStatus(base.ItemId.SerialNumber, Scp1344NetworkHandler.GetSavedStatus(base.ItemId.SerialNumber));
			}
		}

		private void ClientChangeStatus(ushort serial, Scp1344Status status)
		{
			if (base.ItemId.SerialNumber == serial)
			{
				switch (status)
				{
				case Scp1344Status.Inspecting:
					AnimatorSetTrigger(InspectAnimHash);
					PlayClip(_inspectSound, _originalVolume);
					break;
				case Scp1344Status.Dropping:
					AnimatorSetInt(StatusAnimHash, (int)status);
					PlayClip(_removeBuildUpSound);
					break;
				default:
					AnimatorSetInt(StatusAnimHash, (int)status);
					break;
				}
				_status = status;
			}
		}

		private void Awake()
		{
			_audioSource = base.gameObject.GetComponent<AudioSource>();
			_originalClip = _audioSource.clip;
			_originalVolume = _audioSource.volume;
		}

		private void OnDisable()
		{
			_audioSource.clip = _originalClip;
		}

		private void PlayClip(AudioClip clip, float volume = 1f)
		{
			_audioSource.clip = clip;
			_audioSource.volume = volume;
			_audioSource.Play();
		}
	}
}
