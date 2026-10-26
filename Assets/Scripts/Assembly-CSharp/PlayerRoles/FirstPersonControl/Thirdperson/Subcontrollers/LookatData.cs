using System;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers
{
	[Serializable]
	public struct LookatData
	{
		public Vector3 LookDir;

		public float GlobalWeight;

		public float BodyWeight;

		public float HeadWeight;

		public LookatData LerpTo(LookatData target, float weight)
		{
			if (weight <= 0f)
			{
				return this;
			}
			if (weight >= 1f)
			{
				return target;
			}
			return new LookatData
			{
				LookDir = Vector3.Slerp(LookDir, target.LookDir, weight),
				GlobalWeight = Mathf.Lerp(GlobalWeight, target.GlobalWeight, weight),
				BodyWeight = Mathf.Lerp(BodyWeight, target.BodyWeight, weight),
				HeadWeight = Mathf.Lerp(HeadWeight, target.HeadWeight, weight)
			};
		}
	}
}
