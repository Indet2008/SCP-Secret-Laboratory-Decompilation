using System;
using AnimatorLayerManagement;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers
{
	public class FeetStabilizerSubcontroller : SubcontrollerBehaviour
	{
		[Serializable]
		private class Foot
		{
			[SerializeField]
			private AvatarIKGoal _goal;

			[SerializeField]
			private HumanBodyBones _bone;

			[SerializeField]
			private Vector3 _modelspacePosition;

			[SerializeField]
			private bool _calibrate;

			private Transform _footTr;

			public void Init(Animator anim)
			{
				_footTr = anim.GetBoneTransform(_bone);
			}

			public void OnIK(AnimatedCharacterModel model, float weight)
			{
				Transform cachedTransform = model.CachedTransform;
				if (_calibrate)
				{
					_modelspacePosition = cachedTransform.InverseTransformPoint(_footTr.position);
					return;
				}
				Vector3 goalPosition = cachedTransform.TransformPoint(_modelspacePosition);
				model.Animator.SetIKPosition(_goal, goalPosition);
				model.Animator.SetIKPositionWeight(_goal, weight);
			}
		}

		[SerializeField]
		private LayerRefId _ikLayer;

		[SerializeField]
		private Foot[] _feet;

		[SerializeField]
		private float _maxWeightAdjustSpeed;

		[SerializeField]
		private float _maxWeightTurnDecreaseSpeed;

		private IRotationRetainer _rotationRetainer;

		private float _lastRetentionWeight;

		private float _maxWeight;

		public override void Init(AnimatedCharacterModel model, int index)
		{
			base.Init(model, index);
			if (!model.TryGetSubcontroller<IRotationRetainer>(out _rotationRetainer))
			{
				throw new InvalidOperationException("FeetStabilizerSubcontroller requires IRotationRetainer to operate!");
			}
			if (base.HasCuller)
			{
				base.Culler.OnAnimatorUpdated += UpdateWeight;
			}
			Foot[] feet = _feet;
			for (int i = 0; i < feet.Length; i++)
			{
				feet[i].Init(model.Animator);
			}
		}

		private void OnAnimatorIK(int layerIndex)
		{
			if (layerIndex == base.Model.LayerManager.GetLayerIndex(_ikLayer) && !base.Culled && (!base.HasOwner || !(base.OwnerHub.transform.localScale != Vector3.one)))
			{
				_lastRetentionWeight = _rotationRetainer.RetentionWeight;
				Foot[] feet = _feet;
				for (int i = 0; i < feet.Length; i++)
				{
					feet[i].OnIK(base.Model, Mathf.Min(_lastRetentionWeight, _maxWeight));
				}
			}
		}

		private void UpdateWeight()
		{
			float lastMovedDeltaT = base.Model.LastMovedDeltaT;
			if (_rotationRetainer.IsTurning)
			{
				_maxWeight -= _maxWeightTurnDecreaseSpeed * lastMovedDeltaT;
				if (_maxWeight < 0f)
				{
					_maxWeight = 0f;
				}
			}
			else
			{
				_maxWeight = Mathf.MoveTowards(_maxWeight, _lastRetentionWeight, lastMovedDeltaT * _maxWeightAdjustSpeed);
			}
		}

		private void Update()
		{
			if (!base.HasCuller)
			{
				UpdateWeight();
			}
		}
	}
}
