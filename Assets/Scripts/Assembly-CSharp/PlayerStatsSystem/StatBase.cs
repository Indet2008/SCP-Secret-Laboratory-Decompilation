using UnityEngine;

namespace PlayerStatsSystem
{
	public abstract class StatBase
	{
		public abstract float CurValue { get; set; }

		public abstract float MinValue { get; }

		public abstract float MaxValue { get; set; }

		public float NormalizedValue
		{
			get
			{
				if (MinValue != MaxValue)
				{
					return (CurValue - MinValue) / (MaxValue - MinValue);
				}
				return 0f;
			}
		}

		public ReferenceHub Hub { get; private set; }

		public void AddAmount(float amount)
		{
			CurValue = Mathf.Clamp(CurValue + amount, MinValue, MaxValue);
		}

		public void AddAmount(float amount, float percentageCap)
		{
			float max = MaxValue * Mathf.Clamp01(percentageCap);
			float value = CurValue + amount;
			CurValue = Mathf.Clamp(value, MinValue, max);
		}

		internal virtual void Init(ReferenceHub ply)
		{
			Hub = ply;
		}

		internal virtual void Update()
		{
		}

		internal virtual void ClassChanged()
		{
		}
	}
}
