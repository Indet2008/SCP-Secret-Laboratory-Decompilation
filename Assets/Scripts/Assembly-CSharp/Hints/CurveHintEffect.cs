using System;
using Mirror;
using UnityEngine;
using Utils.Networking;

namespace Hints
{
	public abstract class CurveHintEffect : HintEffect
	{
		private AnimationCurve _curve;

		protected AnimationCurve Curve
		{
			get
			{
				return _curve;
			}
			set
			{
				if (value != null && value.length > 0)
				{
					IterationScalar = value[value.length - 1].time - value[0].time;
					IterationScalar *= IterationScalar;
				}
				else
				{
					IterationScalar = 0f;
				}
				_curve = value;
			}
		}

		protected float IterationScalar { get; private set; }

		protected CurveHintEffect(float startScalar = 0f, float durationScalar = 1f)
			: base(startScalar, durationScalar)
		{
		}

		protected CurveHintEffect(AnimationCurve curve, float startScalar = 0f, float durationScalar = 1f)
			: this(startScalar, durationScalar)
		{
			Curve = curve ?? throw new ArgumentNullException("curve");
		}

		public override void Deserialize(NetworkReader reader)
		{
			base.Deserialize(reader);
			Curve = reader.ReadAnimationCurve();
		}

		public override void Serialize(NetworkWriter writer)
		{
			base.Serialize(writer);
			writer.WriteAnimationCurve(Curve);
		}

		protected float EvaluateCurve(float progress)
		{
			return _curve.Evaluate(progress * IterationScalar);
		}
	}
}
