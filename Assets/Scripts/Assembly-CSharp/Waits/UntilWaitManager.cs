using System;
using System.Collections.Generic;
using MEC;

namespace Waits
{
	public abstract class UntilWaitManager : WaitManager
	{
		protected Func<bool> allocatedKeepRunning;

		protected override void Awake()
		{
			base.Awake();
			allocatedKeepRunning = KeepRunning;
		}

		protected abstract bool KeepRunning();

		public override IEnumerator<float> _Run()
		{
			StartAll();
			yield return float.NegativeInfinity;
			yield return Timing.WaitUntilFalse(allocatedKeepRunning);
		}
	}
}
