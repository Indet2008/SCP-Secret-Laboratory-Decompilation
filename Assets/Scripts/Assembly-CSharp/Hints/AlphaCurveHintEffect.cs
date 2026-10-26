using Mirror;
using UnityEngine;

namespace Hints
{
	public class AlphaCurveHintEffect : CurveHintEffect
	{
		public static AlphaCurveHintEffect FromNetwork(NetworkReader reader)
		{
			AlphaCurveHintEffect alphaCurveHintEffect = new AlphaCurveHintEffect();
			alphaCurveHintEffect.Deserialize(reader);
			return alphaCurveHintEffect;
		}

		private AlphaCurveHintEffect()
		{
		}

		public AlphaCurveHintEffect(AnimationCurve curve, float startScalar = 0f, float durationScalar = 1f)
			: base(curve, startScalar, durationScalar)
		{
		}
	}
}
