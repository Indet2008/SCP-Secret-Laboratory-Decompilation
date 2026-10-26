using System;
using Respawning.Waves;
using UnityEngine;

namespace Respawning.Graphics
{
	public abstract class WaveInterfaceBase<TWave> : MonoBehaviour where TWave : SpawnableWaveBase
	{
		public TWave Wave { get; protected set; }

		protected virtual void Awake()
		{
			if (!WaveManager.TryGet<TWave>(out var spawnWave))
			{
				throw new NullReferenceException("Unable to find reference to " + typeof(TWave).Name + ".");
			}
			Wave = spawnWave;
		}
	}
}
