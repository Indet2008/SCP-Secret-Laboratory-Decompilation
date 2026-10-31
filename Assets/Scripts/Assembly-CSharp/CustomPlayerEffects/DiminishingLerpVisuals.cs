using UnityEngine;
using UnityEngine.Rendering;

namespace CustomPlayerEffects
{
	public class DiminishingLerpVisuals : LerpVisualsBase
	{
		[SerializeField]
		private AnimationCurve _intensityCurve;

		[SerializeField]
		private float _diminishingTime = 1f;

		private Volume _processVolume;

		public float Intensity
		{
			get
			{
				return base.Weight;
			}
			set
			{
				base.Weight = value;
			}
		}

		protected override void Awake()
		{
			base.Awake();
			_processVolume = GetComponent<Volume>();
		}

		protected override void Update()
		{
			base.Weight -= Time.deltaTime / _diminishingTime;
		}

		protected override void OnActivated()
		{
			_processVolume.enabled = true;
		}

		protected override void OnShutdown()
		{
			_processVolume.enabled = false;
		}

		protected override void OnWeightChanged(float weight)
		{
			_processVolume.weight = _intensityCurve.Evaluate(weight);
		}
	}
}
