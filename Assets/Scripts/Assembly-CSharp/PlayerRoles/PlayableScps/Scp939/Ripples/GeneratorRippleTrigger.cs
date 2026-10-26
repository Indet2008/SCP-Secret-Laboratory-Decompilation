using MapGeneration.Distributors;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Ripples
{
	public class GeneratorRippleTrigger : RippleTriggerBase
	{
		private readonly Vector3 _offset = Vector3.up * 1.5f;

		private const float RangeSqr = 100f;

		public override void SpawnObject()
		{
			base.SpawnObject();
			Scp079Generator.OnCount += OnCount;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			Scp079Generator.OnCount -= OnCount;
		}

		private void OnCount(Scp079Generator generator)
		{
			if (base.IsLocalOrSpectated)
			{
				PlayInRangeSqr(generator.transform.position + _offset, 100f, Color.red);
			}
		}
	}
}
