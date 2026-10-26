using System;
using UnityEngine;

namespace Waits
{
	public class VelocityUntilWait : UntilWait
	{
		[NonSerialized]
		private float sqrThreshold;

		public Rigidbody rigidbody;

		public float threshold = 0.05f;

		protected override void Awake()
		{
			base.Awake();
			sqrThreshold = threshold * threshold;
		}

		protected override bool Predicate()
		{
			return rigidbody.linearVelocity.sqrMagnitude < sqrThreshold;
		}
	}
}
