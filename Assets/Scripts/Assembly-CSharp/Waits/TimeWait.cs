using System.Collections.Generic;
using MEC;

namespace Waits
{
	public class TimeWait : Wait
	{
		public float duration = 10f;

		public override IEnumerator<float> _Run()
		{
			yield return Timing.WaitForSeconds(duration);
		}
	}
}
