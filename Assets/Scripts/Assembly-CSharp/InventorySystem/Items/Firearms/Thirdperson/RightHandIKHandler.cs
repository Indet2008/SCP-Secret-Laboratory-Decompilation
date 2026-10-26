using System;
using InventorySystem.Items.Firearms.Extensions;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Thirdperson
{
	[Serializable]
	public class RightHandIKHandler : IHandPoseModifier
	{
		[Serializable]
		private struct RightHandSettings
		{
			public float IKPositionWeight;

			public Vector3 IKPosition;

			public float PoseTime;

			public float PoseWeight;

			public ConditionalEvaluator Condition;

			public RightHandSettings LerpTo(RightHandSettings target, float weight)
			{
				if (weight <= 0f)
				{
					return this;
				}
				if (weight >= 1f)
				{
					return target;
				}
				return new RightHandSettings
				{
					IKPositionWeight = Mathf.Lerp(IKPositionWeight, target.IKPositionWeight, weight),
					IKPosition = Vector3.Lerp(IKPosition, target.IKPosition, weight),
					PoseTime = Mathf.Lerp(PoseTime, target.PoseTime, weight),
					PoseWeight = Mathf.Lerp(PoseWeight, target.PoseWeight, weight)
				};
			}
		}

		private const float MinAimDistance = 1.2f;

		private const float IgnoreAimDistance = 0.05f;

		private const float CorrectionLerpSpeed = 9f;

		private Vector2 _prevCorrection;

		private float _lastAdsBlend;

		private AnimatedCharacterModel _model;

		[SerializeField]
		private Vector3 _handRotation;

		[SerializeField]
		private RightHandSettings[] _hipSettings;

		[SerializeField]
		private RightHandSettings[] _adsSettings;

		[SerializeField]
		private float _aimCorrectionIntensity;

		public HandPoseData ProcessHandPose(HandPoseData data)
		{
			RightHandSettings curSettings = GetCurSettings(_lastAdsBlend);
			data.RightHandPose = curSettings.PoseTime;
			data.RightHandWeight = curSettings.PoseWeight;
			return data;
		}

		public void Initialize(FirearmWorldmodel woldmodel, AnimatedCharacterModel model)
		{
			_model = model;
			RightHandSettings[] adsSettings = _adsSettings;
			for (int i = 0; i < adsSettings.Length; i++)
			{
				adsSettings[i].Condition.InitWorldmodel(woldmodel);
			}
			adsSettings = _hipSettings;
			for (int i = 0; i < adsSettings.Length; i++)
			{
				adsSettings[i].Condition.InitWorldmodel(woldmodel);
			}
		}

		public void IKUpdateRightHandRotation(float ikScale, float adsBlend)
		{
			_lastAdsBlend = adsBlend;
			Animator animator = _model.Animator;
			Transform transform = (_model.HasOwner ? _model.OwnerHub.PlayerCameraReference : _model.transform);
			Transform boneTransform = animator.GetBoneTransform(HumanBodyBones.RightHand);
			Vector3 vector = (_model.HasOwner ? MainCameraController.CurrentCamera.position : _model.transform.position);
			Vector3 vector2 = transform.forward.NormalizeIgnoreY();
			Vector2 vector3 = new Vector2(vector.x, vector.z);
			Vector2 vector4 = new Vector2(transform.position.x, transform.position.z);
			Vector2 vector5 = new Vector2(vector2.x, vector2.z);
			float num = Vector2.Dot(vector3 - vector4, vector5);
			float sqrMagnitude = (vector4 + num * vector5 - vector3).sqrMagnitude;
			Vector2 b;
			if (sqrMagnitude > 0.1f || num < 0f)
			{
				b = Vector2.zero;
			}
			else
			{
				float blend = Mathf.InverseLerp(0.1f, 0.04f, sqrMagnitude);
				float aimDistance = Vector2.Distance(vector3, vector4);
				b = CalculateAimCorrection(blend, aimDistance, transform, boneTransform);
			}
			float t = 9f * _model.LastMovedDeltaT;
			Vector2 vector6 = Vector2.Lerp(_prevCorrection, b, t);
			ApplyIKRotation(transform, vector6, ikScale);
			ApplyIKPosition(transform, boneTransform, ikScale);
			_prevCorrection = vector6;
		}

		private Vector2 CalculateAimCorrection(float blend, float aimDistance, Transform cam, Transform rightHand)
		{
			if (aimDistance < 0.05f)
			{
				aimDistance = 1.2f;
				blend = 0f;
			}
			else if (aimDistance < 1.2f)
			{
				aimDistance = 1.2f;
			}
			Vector3 vector = cam.InverseTransformPoint(rightHand.position);
			Vector2 vector2 = new Vector2(Mathf.Atan2(aimDistance, vector.x) * 57.29578f - 90f, Mathf.Atan2(aimDistance, vector.y) * 57.29578f - 90f);
			return _aimCorrectionIntensity * blend * vector2;
		}

		private void ApplyIKRotation(Transform cam, Vector2 correction, float ikScale)
		{
			Quaternion quaternion = cam.rotation * Quaternion.Euler(_handRotation);
			Quaternion goalRotation = Quaternion.Euler(0f - correction.x, (0f - correction.y) / 2f, 0f) * quaternion;
			_model.Animator.SetIKRotation(AvatarIKGoal.RightHand, goalRotation);
			_model.Animator.SetIKRotationWeight(AvatarIKGoal.RightHand, ikScale);
		}

		private void ApplyIKPosition(Transform cam, Transform rightHand, float ikScale)
		{
			RightHandSettings curSettings = GetCurSettings(_lastAdsBlend);
			if (curSettings.IKPositionWeight > 0f)
			{
				_model.Animator.SetIKPosition(AvatarIKGoal.RightHand, rightHand.position + cam.TransformDirection(curSettings.IKPosition));
				_model.Animator.SetIKPositionWeight(AvatarIKGoal.RightHand, curSettings.IKPositionWeight * ikScale);
			}
		}

		private RightHandSettings GetCurSettings(float adsBlend)
		{
			RightHandSettings? rightHandSettings = null;
			RightHandSettings? rightHandSettings2 = null;
			RightHandSettings[] hipSettings = _hipSettings;
			for (int i = 0; i < hipSettings.Length; i++)
			{
				RightHandSettings value = hipSettings[i];
				if (value.Condition.Evaluate())
				{
					rightHandSettings = value;
					break;
				}
			}
			hipSettings = _adsSettings;
			for (int i = 0; i < hipSettings.Length; i++)
			{
				RightHandSettings value2 = hipSettings[i];
				if (value2.Condition.Evaluate())
				{
					rightHandSettings2 = value2;
					break;
				}
			}
			return rightHandSettings.GetValueOrDefault().LerpTo(rightHandSettings2.GetValueOrDefault(), adsBlend);
		}
	}
}
