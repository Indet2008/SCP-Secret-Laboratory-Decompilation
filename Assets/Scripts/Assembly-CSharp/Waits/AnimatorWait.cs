using System.Collections.Generic;
using MEC;
using UnityEngine;

namespace Waits
{
	public class AnimatorWait : Wait
	{
		public Animator animator;

		public override IEnumerator<float> _Run()
		{
			yield return Timing.WaitUntilFalse(() => animator.GetCurrentAnimatorStateInfo(0).normalizedTime < 1f);
		}
	}
}
