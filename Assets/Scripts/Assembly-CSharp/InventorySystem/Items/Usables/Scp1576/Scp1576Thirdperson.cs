using AnimatorLayerManagement;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp1576
{
	public class Scp1576Thirdperson : VariableGFXUsableItemThirdperson
	{
		[SerializeField]
		private Transform _leftHandIkTarget;

		[SerializeField]
		private LayerRefId _leftHandIkLayer;

		[SerializeField]
		private Pose _leftHandLocalPose;

		[SerializeField]
		private Vector2 _crankingPeriodMinMax;

		[SerializeField]
		private Transform _crankAnchor;

		[SerializeField]
		private Vector3 _crankForward;

		[SerializeField]
		private Vector3 _crankParentUp;

		[SerializeField]
		private float _animEndTime;

		private float _elapsed;

		private Transform _crankTr;

		private Transform _lastInstanceTr;

		private Pose _initialInstPose;

		private Pose _targetInstPose;

		private float _ikBlend;

		private const float IkBlendSpeed = 4f;

		private const float PoseAdjustDuration = 0.2f;

		internal override void OnAnimIK(int layerIndex, float ikScale)
		{
			base.OnAnimIK(layerIndex, ikScale);
			if (_ikBlend > 0f)
			{
				UpdateIdleIK(layerIndex);
			}
		}

		protected override void SetupLeftHandedInstance(GameObject instance, Transform leftHand)
		{
			_lastInstanceTr = instance.transform;
			_lastInstanceTr.SetParent(leftHand);
			base.MainGfx.transform.GetPositionAndRotation(out var position, out var rotation);
			_lastInstanceTr.SetPositionAndRotation(position, rotation);
			_lastInstanceTr.GetLocalPositionAndRotation(out var localPosition, out var localRotation);
			Vector3 lossyScale = leftHand.lossyScale;
			Vector3 position2 = _leftHandLocalPose.position;
			Vector3 position3 = new Vector3(position2.x / lossyScale.x, position2.y / lossyScale.y, position2.z / lossyScale.z);
			_initialInstPose = new Pose(localPosition, localRotation);
			_targetInstPose = new Pose(position3, _leftHandLocalPose.rotation);
			instance.SetActive(value: true);
			_crankTr = instance.GetComponentInChildren<ConfigurableJoint>().transform;
		}

		protected override void Update()
		{
			base.Update();
			if (!base.IsUsing)
			{
				_elapsed = 0f;
				SetIkSmooth(targetIsOn: true);
				return;
			}
			_elapsed += Time.deltaTime;
			float t = Mathf.Clamp01(_elapsed / 0.2f);
			_lastInstanceTr.SetLocalPositionAndRotation(Vector3.Lerp(_initialInstPose.position, _targetInstPose.position, t), Quaternion.Lerp(_initialInstPose.rotation, _targetInstPose.rotation, t));
			if (_elapsed > _crankingPeriodMinMax.x && _elapsed < _crankingPeriodMinMax.y)
			{
				Crank();
			}
			SetIkSmooth(targetIsOn: false);
			if (_elapsed > _animEndTime)
			{
				base.IsUsing = false;
				OnUsingStatusChanged();
			}
		}

		private bool Crank()
		{
			Vector3 vector = _crankAnchor.position - _crankTr.position;
			Vector3 vector2 = _crankTr.parent.TransformDirection(_crankParentUp);
			Quaternion quaternion = Quaternion.LookRotation(Vector3.ProjectOnPlane(vector, vector2), vector2);
			Quaternion quaternion2 = Quaternion.FromToRotation(_crankForward, Vector3.forward);
			_crankTr.rotation = quaternion * quaternion2;
			return true;
		}

		private void UpdateIdleIK(int layer)
		{
			AnimatorLayerManager layerManager = base.TargetModel.LayerManager;
			if (layer == layerManager.GetLayerIndex(_leftHandIkLayer))
			{
				Animator animator = base.TargetModel.Animator;
				_leftHandIkTarget.GetPositionAndRotation(out var position, out var rotation);
				animator.SetIKPosition(AvatarIKGoal.LeftHand, position);
				animator.SetIKPositionWeight(AvatarIKGoal.LeftHand, _ikBlend);
				animator.SetIKRotation(AvatarIKGoal.LeftHand, rotation);
				animator.SetIKRotationWeight(AvatarIKGoal.LeftHand, _ikBlend);
			}
		}

		private void SetIkSmooth(bool targetIsOn)
		{
			_ikBlend = Mathf.MoveTowards(_ikBlend, targetIsOn ? 1 : 0, Time.deltaTime * 4f);
		}
	}
}
