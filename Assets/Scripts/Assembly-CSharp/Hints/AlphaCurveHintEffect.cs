using Mirror;
using UnityEngine;

namespace Hints
{
	public class AlphaCurveHintEffect : CurveHintEffect
	{
		private float _oldAlpha;

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

		protected override void Start()
		{
			_oldAlpha = base.Data.Textbox.alpha;
		}

		protected override void UpdateState(float progress)
		{
			base.Data.Textbox.alpha = EvaluateCurve(progress);
		}

		protected override void Destroy()
		{
			if (base.Data.Textbox != null)
			{
				base.Data.Textbox.alpha = _oldAlpha;
			}
		}
	}
}
