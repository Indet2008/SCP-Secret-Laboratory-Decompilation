using System;
using Respawning.Waves;
using UnityEngine;

namespace Respawning.Graphics
{
	public abstract class SerializedWaveInterface : WaveInterfaceBase<SpawnableWaveBase>
	{
		[HideInInspector]
		public string WaveIdentifier;

		protected override void Awake()
		{
			RefreshWave();
		}

		internal void RefreshWave()
		{
			foreach (SpawnableWaveBase wave in WaveManager.Waves)
			{
				if (wave.GetType().Name.Equals(WaveIdentifier, StringComparison.OrdinalIgnoreCase))
				{
					base.Wave = wave;
					return;
				}
			}
			throw new NullReferenceException("Unable to find any Wave by the " + WaveIdentifier + " name.");
		}
	}
}
