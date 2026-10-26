using InventorySystem.Items.Thirdperson;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;

namespace InventorySystem.Items.Jailbird
{
	public class JailbirdThirdperson : ThirdpersonItemBase
	{
		private const float ChargeAudioRadiusMultiplier = 3f;

		private AnimState3p _targetAnim;

		private float _defaultAudioMaxDistance;

		[SerializeField]
		private AnimationClip _idleAnim;

		[SerializeField]
		private AnimationClip _chargingAnim;

		[SerializeField]
		private AnimationClip _swingAnim;

		[SerializeField]
		private AnimationClip _chargeHitAnim;

		[SerializeField]
		private AudioClip _attackSound;

		[SerializeField]
		private AudioClip _chargeSound;

		[SerializeField]
		private AudioClip _chargeLoadSound;

		[SerializeField]
		private AudioSource _audioSource;

		[SerializeField]
		private float _blendAdjustSpeed;

		[SerializeField]
		private JailbirdMaterialController _materialController;

		[SerializeField]
		private GameObject _chargeLoadParticles;

		[SerializeField]
		private GameObject _chargingParticles;

		public override void ResetObject()
		{
			base.ResetObject();
			JailbirdItem.OnRpcReceived -= OnRpcReceived;
			_chargeLoadParticles.SetActive(value: false);
			_chargingParticles.SetActive(value: false);
		}

		internal override void Initialize(InventorySubcontroller subcontroller, ItemIdentifier id)
		{
			base.Initialize(subcontroller, id);
			_materialController.SetSerial(id.SerialNumber);
			SetAnim(AnimState3p.Override0, _idleAnim);
			SetAnim(AnimState3p.Override1, _chargingAnim);
			_targetAnim = AnimState3p.Override0;
			_defaultAudioMaxDistance = _audioSource.maxDistance;
			base.OverrideBlend = 0f;
			JailbirdItem.OnRpcReceived += OnRpcReceived;
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

		private void OnRpcReceived(ushort serial, JailbirdMessageType rpc)
		{
			if (serial != base.ItemId.SerialNumber)
			{
				return;
			}
			bool flag = false;
			bool flag2 = false;
			_audioSource.maxDistance = _defaultAudioMaxDistance;
			switch (rpc)
			{
			default:
				return;
			case JailbirdMessageType.AttackPerformed:
				if (_targetAnim == AnimState3p.Override1)
				{
					PlayAttack(_chargeHitAnim);
					break;
				}
				return;
			case JailbirdMessageType.AttackTriggered:
				PlayAttack(_swingAnim);
				break;
			case JailbirdMessageType.ChargeFailed:
				_audioSource.Stop();
				_targetAnim = AnimState3p.Override0;
				break;
			case JailbirdMessageType.ChargeLoadTriggered:
				_targetAnim = AnimState3p.Override1;
				flag = true;
				_audioSource.PlayOneShot(_chargeLoadSound);
				break;
			case JailbirdMessageType.ChargeStarted:
				_targetAnim = AnimState3p.Override1;
				flag2 = true;
				_audioSource.maxDistance *= 3f;
				_audioSource.PlayOneShot(_chargeSound);
				break;
			}
			_chargingParticles.SetActive(flag2);
			_chargeLoadParticles.SetActive(flag | flag2);
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
