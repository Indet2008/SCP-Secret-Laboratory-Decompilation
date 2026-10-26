using InventorySystem.Items.Thirdperson;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;

namespace InventorySystem.Items.Scp1509
{
	public class Scp1509Thirdperson : ThirdpersonItemBase
	{
		private AnimState3p _targetAnim;

		private float _defaultAudioMaxDistance;

		private bool _swung;

		[SerializeField]
		private AnimationClip _idleAnim;

		[SerializeField]
		private AnimationClip _swing1Anim;

		[SerializeField]
		private AnimationClip _swing2Anim;

		[SerializeField]
		private AudioClip _attackSound;

		[SerializeField]
		private AudioSource _audioSource;

		[SerializeField]
		private float _blendAdjustSpeed;

		[SerializeField]
		private ParticleSystem[] _resurrectParticles;

		[SerializeField]
		private Material _bloodyMaterial;

		[SerializeField]
		private Material _regularMaterial;

		[SerializeField]
		private MeshRenderer _scp1509Mesh;

		private bool ReceivedStatus
		{
			get
			{
				if (!Scp1509Item.ResurrectStatuses.TryGetValue(base.ItemId.SerialNumber, out var value))
				{
					return false;
				}
				return value;
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			Scp1509Item.OnRpcReceived -= OnRpcReceived;
			SetResurrectParticleState(active: false);
			_scp1509Mesh.sharedMaterial = _regularMaterial;
		}

		internal override void Initialize(InventorySubcontroller subcontroller, ItemIdentifier id)
		{
			base.Initialize(subcontroller, id);
			SetAnim(AnimState3p.Override0, _idleAnim);
			_defaultAudioMaxDistance = _audioSource.maxDistance;
			_scp1509Mesh.sharedMaterial = _regularMaterial;
			_targetAnim = AnimState3p.Override0;
			base.OverrideBlend = 0f;
			Scp1509Item.OnRpcReceived += OnRpcReceived;
			SetResurrectParticleState(ReceivedStatus);
		}

		public override ThirdpersonLayerWeight GetWeightForLayer(AnimItemLayer3p layer)
		{
			return new ThirdpersonLayerWeight(1f, layer != AnimItemLayer3p.Right && _targetAnim == AnimState3p.Override0);
		}

		protected override void Update()
		{
			base.Update();
			base.OverrideBlend = Mathf.MoveTowards(base.OverrideBlend, (float)_targetAnim, Time.deltaTime * _blendAdjustSpeed);
		}

		private void OnRpcReceived(ushort serial, Scp1509MessageType rpc)
		{
			if (serial == base.ItemId.SerialNumber)
			{
				_audioSource.maxDistance = _defaultAudioMaxDistance;
				switch (rpc)
				{
				case Scp1509MessageType.AttackTriggered:
					PlayAttack(_swung ? _swing2Anim : _swing1Anim);
					_swung = !_swung;
					break;
				case Scp1509MessageType.CanResurrect:
					SetResurrectParticleState(active: true);
					break;
				case Scp1509MessageType.CanNotResurrect:
					SetResurrectParticleState(active: false);
					break;
				case Scp1509MessageType.KilledPlayer:
					_scp1509Mesh.sharedMaterial = _bloodyMaterial;
					break;
				}
			}
		}

		private void SetResurrectParticleState(bool active)
		{
			ParticleSystem[] resurrectParticles = _resurrectParticles;
			foreach (ParticleSystem particleSystem in resurrectParticles)
			{
				ParticleSystem.MainModule main = particleSystem.main;
				main.loop = active;
				main.playOnAwake = active;
				if (active)
				{
					particleSystem.Play();
				}
				else
				{
					particleSystem.Stop();
				}
			}
		}

		private void PlayAttack(AnimationClip clip)
		{
			_targetAnim = AnimState3p.Override0;
			SetAnim(_targetAnim, clip);
			ReplayOverrideBlend(soft: false);
			_audioSource.Stop();
			_audioSource.PlayOneShot(_attackSound);
		}
	}
}
