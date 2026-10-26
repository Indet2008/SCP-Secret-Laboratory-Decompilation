using System.Collections.Generic;
using MEC;
using UnityEngine;

namespace Waits
{
	public abstract class WaitManager : MonoBehaviour
	{
		protected Wait[] waits;

		protected CoroutineHandle[] waitHandles;

		protected virtual void Awake()
		{
			waits = GetComponents<Wait>();
			waitHandles = new CoroutineHandle[waits.Length];
		}

		protected void StartAll()
		{
			for (int i = 0; i < waits.Length; i++)
			{
				waitHandles[i] = Timing.RunCoroutine(waits[i]._Run());
			}
		}

		public abstract IEnumerator<float> _Run();
	}
}
