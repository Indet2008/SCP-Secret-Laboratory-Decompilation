using System;
using InventorySystem.Items.Firearms.Extensions;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Thirdperson
{
	[Serializable]
	public class LeftHandIKHandler : IHandPoseModifier
	{
		[Serializable]
		private struct Anchor
		{
			public Transform Point;

			public float PoseTime;

			public float PoseOverride;

			public ConditionalEvaluator Condition;
		}

		private Animator _anim;

		[SerializeField]
		private Anchor[] _anchors;

		public HandPoseData ProcessHandPose(HandPoseData data)
		{
			Anchor[] anchors = _anchors;
			for (int i = 0; i < anchors.Length; i++)
			{
				Anchor anchor = anchors[i];
				if (anchor.Condition.Evaluate())
				{
					data.LeftHandPose = anchor.PoseTime;
					data.LeftHandWeight = anchor.PoseOverride;
					break;
				}
			}
			return data;
		}

		public void Initialize(FirearmWorldmodel woldmodel, AnimatedCharacterModel model)
		{
			_anim = model.Animator;
			Anchor[] anchors = _anchors;
			for (int i = 0; i < anchors.Length; i++)
			{
				anchors[i].Condition.InitWorldmodel(woldmodel);
			}
		}

		public void IKUpdateLeftHandAnchor(float ikScale)
		{
			bool flag = false;
			Anchor[] anchors = _anchors;
			for (int i = 0; i < anchors.Length; i++)
			{
				Anchor anchor = anchors[i];
				if (anchor.Condition.Evaluate())
				{
					_anim.SetIKPosition(AvatarIKGoal.LeftHand, anchor.Point.position);
					_anim.SetIKPositionWeight(AvatarIKGoal.LeftHand, ikScale);
					_anim.SetIKRotation(AvatarIKGoal.LeftHand, anchor.Point.rotation);
					_anim.SetIKRotationWeight(AvatarIKGoal.LeftHand, ikScale);
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				_anim.SetIKPositionWeight(AvatarIKGoal.LeftHand, 0f);
				_anim.SetIKRotationWeight(AvatarIKGoal.LeftHand, 0f);
			}
		}
	}
}
