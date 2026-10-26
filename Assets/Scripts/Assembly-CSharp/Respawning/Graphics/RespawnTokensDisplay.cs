using Respawning.Waves.Generic;
using TMPro;
using UnityEngine;

namespace Respawning.Graphics
{
	public class RespawnTokensDisplay : SerializedWaveInterface
	{
		[SerializeField]
		private TextMeshProUGUI _respawnTokens;

		private int _lastTokens = 1;

		private void Update()
		{
			if (base.Wave is ILimitedWave { RespawnTokens: var respawnTokens } && respawnTokens != _lastTokens)
			{
				_lastTokens = respawnTokens;
				_respawnTokens.text = respawnTokens.ToString();
			}
		}
	}
}
