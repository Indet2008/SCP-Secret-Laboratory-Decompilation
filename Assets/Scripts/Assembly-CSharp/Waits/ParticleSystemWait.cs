using System;
using System.Collections.Generic;
using MEC;
using UnityEngine;

namespace Waits
{
	public class ParticleSystemWait : Wait
	{
		private Func<bool> isAliveDelegate;

		public ParticleSystem particleSystem;

		protected virtual void Awake()
		{
			isAliveDelegate = particleSystem.IsAlive;
		}

		public override IEnumerator<float> _Run()
		{
			yield return Timing.WaitUntilFalse(isAliveDelegate);
		}
	}
}
