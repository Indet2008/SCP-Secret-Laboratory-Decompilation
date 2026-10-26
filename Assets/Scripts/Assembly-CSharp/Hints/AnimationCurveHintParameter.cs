using System.Globalization;
using Mirror;
using UnityEngine;
using Utils.Networking;

namespace Hints
{
	public class AnimationCurveHintParameter : HintParameter
	{
		private double _offset;

		private string _format;

		private bool _integral;

		private AnimationCurve _curve;

		public static AnimationCurveHintParameter FromNetwork(NetworkReader reader)
		{
			AnimationCurveHintParameter animationCurveHintParameter = new AnimationCurveHintParameter();
			animationCurveHintParameter.Deserialize(reader);
			return animationCurveHintParameter;
		}

		public AnimationCurveHintParameter(double offset, AnimationCurve curve, string format, bool integral)
		{
			_offset = offset;
			_curve = curve;
			_format = format;
			_integral = integral;
		}

		protected AnimationCurveHintParameter()
		{
		}

		public override void Serialize(NetworkWriter writer)
		{
			writer.WriteDouble(_offset);
			writer.WriteString(_format);
			writer.WriteBool(_integral);
			writer.WriteAnimationCurve(_curve);
		}

		public override void Deserialize(NetworkReader reader)
		{
			_offset = reader.ReadDouble();
			_format = reader.ReadString();
			_integral = reader.ReadBool();
			_curve = reader.ReadAnimationCurve();
		}

		protected override string UpdateState(float progress)
		{
			double num = NetworkTime.time - _offset;
			float f = _curve.Evaluate((float)num);
			if (_integral)
			{
				return Mathf.RoundToInt(f).ToString(_format, CultureInfo.InvariantCulture);
			}
			return f.ToString(_format, CultureInfo.InvariantCulture);
		}
	}
}
