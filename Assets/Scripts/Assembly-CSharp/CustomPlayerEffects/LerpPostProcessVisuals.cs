using UnityEngine;
using UnityEngine.Rendering;

namespace CustomPlayerEffects
{
	public class LerpPostProcessVisuals : LerpVisualsBase
	{
		protected Volume ProcessVolume { get; private set; }

		protected override void Awake()
		{
			base.Awake();
			ProcessVolume = GetComponent<Volume>();
		}

		protected override void OnWeightChanged(float weight)
		{
			ProcessVolume.weight = weight;
		}

		protected override void OnActivated()
		{
			ProcessVolume.enabled = true;
		}

		protected override void OnShutdown()
		{
			ProcessVolume.enabled = false;
		}

		private void OnValidate()
		{
			if (!Application.isPlaying)
			{
				Volume component = GetComponent<Volume>();
				component.weight = 0f;
				component.enabled = false;
			}
		}
	}
}
