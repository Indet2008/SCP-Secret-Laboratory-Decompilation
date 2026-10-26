using System;
using System.Collections.Generic;
using MEC;

namespace Waits
{
	public abstract class UntilWait : Wait
	{
		private Func<bool> allocatedPredicate;

		protected virtual void Awake()
		{
			allocatedPredicate = Predicate;
		}

		protected abstract bool Predicate();

		public override IEnumerator<float> _Run()
		{
			yield return Timing.WaitUntilTrue(allocatedPredicate);
		}
	}
}
