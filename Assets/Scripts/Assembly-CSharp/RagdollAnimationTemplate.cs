using System;
using PlayerRoles.Ragdolls;
using RelativePositioning;
using UnityEngine;

public class RagdollAnimationTemplate : MonoBehaviour
{
	[Serializable]
	private struct RagdollBone
	{
		public Vector3 PositionOffset;

		public Quaternion RotationOffset;

		public Vector3 StartVelocity;
	}

	[SerializeField]
	private RagdollBone[] _bones;

	[SerializeField]
	private Quaternion _overallRotation;

	public void ProcessRagdoll(BasicRagdoll rg)
	{
		if (rg is DynamicRagdoll dynamicRagdoll)
		{
			int num = Mathf.Min(_bones.Length, dynamicRagdoll.LinkedRigidbodies.Length);
			rg.transform.rotation *= _overallRotation;
			for (int i = 0; i < num; i++)
			{
				Rigidbody obj = dynamicRagdoll.LinkedRigidbodies[i];
				RagdollBone ragdollBone = _bones[i];
				Transform obj2 = obj.transform;
				obj2.localRotation = ragdollBone.RotationOffset;
				Quaternion worldRotation = WaypointBase.GetWorldRotation(rg.Info.StartRelativePosition.WaypointId, rg.Info.StartRelativeRotation);
				obj2.position = rg.Info.StartRelativePosition.Position + worldRotation * ragdollBone.PositionOffset;
				obj.linearVelocity = worldRotation * ragdollBone.StartVelocity;
			}
		}
	}
}
