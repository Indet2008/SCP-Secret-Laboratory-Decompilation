using UnityEngine;

namespace Waits
{
	public class AudioSourceUntilWait : UntilWait
	{
		public AudioSource audioSource;

		protected override bool Predicate()
		{
			return !audioSource.isPlaying;
		}
	}
}
