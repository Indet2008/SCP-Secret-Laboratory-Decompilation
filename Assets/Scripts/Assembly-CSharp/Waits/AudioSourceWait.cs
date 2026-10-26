using System.Collections.Generic;
using MEC;
using UnityEngine;

namespace Waits
{
	public class AudioSourceWait : Wait
	{
		public AudioSource audioSource;

		public override IEnumerator<float> _Run()
		{
			yield return Timing.WaitUntilFalse(() => audioSource.isPlaying);
		}
	}
}
