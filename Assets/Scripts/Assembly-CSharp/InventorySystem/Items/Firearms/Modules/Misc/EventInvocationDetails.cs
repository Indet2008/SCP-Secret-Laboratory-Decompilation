using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	public readonly struct EventInvocationDetails
	{
		public readonly bool EverInvoked;

		public readonly float StateSpeed;

		public readonly float ParamSpeed;

		public readonly int Layer;

		public readonly Animator RawAnimator;

		public float TotalSpeedMultiplier => StateSpeed * ParamSpeed;

		public EventInvocationDetails(AnimatorStateInfo stateInfo, Animator sourceAnimator, int callerLayer)
		{
			EverInvoked = true;
			StateSpeed = stateInfo.speed;
			ParamSpeed = stateInfo.speedMultiplier;
			Layer = callerLayer;
			RawAnimator = sourceAnimator;
		}

		public EventInvocationDetails(bool everInvoked, float stateSpeed, float paramSpeed, int layer, Animator rawAnimator)
		{
			EverInvoked = everInvoked;
			StateSpeed = stateSpeed;
			ParamSpeed = paramSpeed;
			Layer = layer;
			RawAnimator = rawAnimator;
		}
	}
}
