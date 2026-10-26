using System;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.Firearms.Modules.Misc;
using InventorySystem.Items.SwayControllers;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class ViewmodelAdsExtension : MonoBehaviour, IViewmodelExtension
	{
		[Serializable]
		private struct RandomizerSettings
		{
			public bool Randomize;

			public int TotalSights;
		}

		[Serializable]
		private class OffsetSettings
		{
			public float AdsFov;

			public Vector3 HipPosition;

			public Vector3 AdsPosition;

			public Vector3 AdsRotation;

			public Vector2 AdsSpeedMultiplierOffset;

			public float ShotAnimIntensity = 1f;

			public void Combine(OffsetSettings toCombine)
			{
				AdsFov += toCombine.AdsFov;
				HipPosition += toCombine.HipPosition;
				AdsPosition += toCombine.AdsPosition;
				AdsRotation += toCombine.AdsRotation;
				AdsSpeedMultiplierOffset += toCombine.AdsSpeedMultiplierOffset;
				ShotAnimIntensity *= toCombine.ShotAnimIntensity;
			}

			public void SetFrom(OffsetSettings source)
			{
				AdsFov = source.AdsFov;
				HipPosition = source.HipPosition;
				AdsPosition = source.AdsPosition;
				AdsRotation = source.AdsRotation;
				AdsSpeedMultiplierOffset = source.AdsSpeedMultiplierOffset;
				ShotAnimIntensity = source.ShotAnimIntensity;
			}
		}

		[Serializable]
		private class AdsAttachmentOffset
		{
			public AttachmentLink TargetAttachment;

			public OffsetSettings OffsetSettings;

			public bool OverridePrevious;
		}

		private static readonly AnimationCurve CorrectionCurve = new AnimationCurve(new Keyframe(0f, 0f, 0.052537024f, 0.052537024f, 0f, 0.13378957f), new Keyframe(0.32f, 0.5f, 2.188895f, 2.188895f, 0.3333f, 0.079453f), new Keyframe(0.65f, 1f, -0.003068474f, -0.003068474f, 0.14362735f, 0f));

		private const float OverallAdsAnimSpeedMultiplier = 5f;

		private readonly OffsetSettings _combinedSettings = new OffsetSettings();

		private AnimatedFirearmViewmodel _viewmodel;

		private Transform _viewmodelTr;

		private Firearm _firearm;

		private IAdsModule _adsModule;

		private float _animationTime;

		private bool _prevAdsTarget;

		private float _prevAdsAmount;

		private bool _initialized;

		private bool _returnAnimation;

		private bool _wasTransitioning;

		[Tooltip("Weight of AdsShotBlend at which the weapon does not move when firing.")]
		[SerializeField]
		private float _noShootingAnimBlendWeight;

		[SerializeField]
		private bool _enableShootingAnimReduction;

		[SerializeField]
		private AnimatorLayerMask _adsAnimsLayer;

		[SerializeField]
		private OffsetSettings _defaultOffset;

		[SerializeField]
		private AdsAttachmentOffset[] _attachmentOffsets;

		[SerializeField]
		private AudioClip _adsInSound;

		[SerializeField]
		private AudioClip _adsOutSound;

		[SerializeField]
		private float _adsInAnimationSpeed = 0.8f;

		[SerializeField]
		private float _adsOutAnimationSpeed = 0.8f;

		[SerializeField]
		private RandomizerSettings _randomizerSettings;

		[field: SerializeField]
		public GoopSway.GoopSwaySettings AdsSway { get; private set; }

		public void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			_firearm = viewmodel.ParentFirearm;
			_viewmodelTr = viewmodel.transform;
			_viewmodel = viewmodel;
			AdsAttachmentOffset[] attachmentOffsets = _attachmentOffsets;
			for (int i = 0; i < attachmentOffsets.Length; i++)
			{
				attachmentOffsets[i].TargetAttachment.InitCache(_firearm);
			}
			if (_firearm.TryGetModule<IAdsModule>(out _adsModule))
			{
				RefreshAttachments();
				_initialized = true;
				_viewmodel.OnAttachmentsUpdated += RefreshAttachments;
				if (viewmodel.IsSpectator)
				{
					_animationTime = (_prevAdsAmount = LinearAdsModule.GetAdsAmountForSerial(_firearm.ItemSerial));
					_returnAnimation = false;
				}
			}
		}

		private void RefreshAttachments()
		{
			_combinedSettings.SetFrom(_defaultOffset);
			for (int i = 0; i < _attachmentOffsets.Length; i++)
			{
				AdsAttachmentOffset adsAttachmentOffset = _attachmentOffsets[i];
				if (adsAttachmentOffset.TargetAttachment.Instance.IsEnabled)
				{
					if (adsAttachmentOffset.OverridePrevious)
					{
						_combinedSettings.SetFrom(adsAttachmentOffset.OffsetSettings);
					}
					else
					{
						_combinedSettings.Combine(adsAttachmentOffset.OffsetSettings);
					}
				}
			}
		}

		private void OnValidate()
		{
			if (_initialized)
			{
				RefreshAttachments();
			}
		}

		private void Update()
		{
			if (_initialized)
			{
				UpdateOffset();
				UpdateSounds();
				int[] layers = _adsAnimsLayer.Layers;
				foreach (int layer in layers)
				{
					UpdateAnims(layer);
				}
			}
		}

		private void UpdateOffset()
		{
			float num = CorrectionCurve.Evaluate(_adsModule.AdsAmount);
			Vector3 localPosition = Vector3.Lerp(_combinedSettings.HipPosition, _combinedSettings.AdsPosition, num);
			Quaternion localRotation = Quaternion.Euler(_combinedSettings.AdsRotation * num);
			_viewmodelTr.SetLocalPositionAndRotation(localPosition, localRotation);
			_viewmodel.FovOffset = _combinedSettings.AdsFov * num;
		}

		private void UpdateSounds()
		{
			if (_firearm.TryGetModule<AudioModule>(out var module))
			{
				float adsAmount = _adsModule.AdsAmount;
				bool flag = adsAmount > 0f && adsAmount < 1f;
				if (flag && !_wasTransitioning)
				{
					module.PlayClientside(_adsModule.AdsTarget ? _adsInSound : _adsOutSound);
				}
				_wasTransitioning = flag;
			}
		}

		private void UpdateAnims(int layer)
		{
			float adsAmount = _adsModule.AdsAmount;
			bool adsTarget = _adsModule.AdsTarget;
			if (_prevAdsTarget != adsTarget)
			{
				if (adsTarget && _prevAdsAmount <= 0f)
				{
					_animationTime = 0f;
					_returnAnimation = false;
					Randomize();
				}
				else if (!adsTarget && _prevAdsAmount >= 1f)
				{
					_animationTime = 1f;
					_returnAnimation = true;
				}
			}
			float target = (adsTarget ? 1 : 0);
			float num = _adsInAnimationSpeed + _combinedSettings.AdsSpeedMultiplierOffset.x;
			float num2 = _adsOutAnimationSpeed + _combinedSettings.AdsSpeedMultiplierOffset.y;
			float num3 = (_returnAnimation ? num2 : num);
			float num4 = _firearm.AttachmentsValue(AttachmentParam.AdsSpeedMultiplier) * 5f * num3;
			_animationTime = Mathf.MoveTowards(_animationTime, target, Time.deltaTime * num4);
			if (_returnAnimation)
			{
				_viewmodel.AnimatorPlay(FirearmAnimatorHashes.AdsOutState, layer, 1f - _animationTime);
				if ((_animationTime == 1f) & adsTarget)
				{
					_returnAnimation = false;
				}
			}
			else
			{
				_viewmodel.AnimatorPlay(FirearmAnimatorHashes.AdsInState, layer, _animationTime);
			}
			_prevAdsTarget = adsTarget;
			_prevAdsAmount = adsAmount;
			_viewmodel.AnimatorSetFloat(FirearmAnimatorHashes.AdsCurrent, adsAmount);
			if (_enableShootingAnimReduction)
			{
				float num5 = Mathf.Lerp(_noShootingAnimBlendWeight, adsAmount, _combinedSettings.ShotAnimIntensity);
				_viewmodel.AnimatorSetFloat(FirearmAnimatorHashes.AdsShotBlend, adsAmount * num5);
			}
		}

		private void Randomize()
		{
			if (_randomizerSettings.Randomize)
			{
				int num = UnityEngine.Random.Range(0, _randomizerSettings.TotalSights);
				_viewmodel.AnimatorSetFloat(FirearmAnimatorHashes.AdsRandom, num);
			}
		}
	}
}
