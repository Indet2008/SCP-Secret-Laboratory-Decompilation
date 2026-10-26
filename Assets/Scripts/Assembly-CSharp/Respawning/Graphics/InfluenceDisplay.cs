using PlayerRoles;
using TMPro;
using UnityEngine;

namespace Respawning.Graphics
{
	public class InfluenceDisplay : SerializedWaveInterface
	{
		[SerializeField]
		private TextMeshProUGUI _influence;

		private bool _maxWavesEarned;

		protected override void Awake()
		{
			base.Awake();
			Faction targetFaction = base.Wave.TargetFaction;
			UpdateDisplay(targetFaction, FactionInfluenceManager.Get(targetFaction));
			FactionInfluenceManager.InfluenceModified += UpdateDisplay;
			WaveManager.OnWaveUpdateMsgReceived += OnWaveUpdateMsgReceived;
		}

		private void OnDestroy()
		{
			FactionInfluenceManager.InfluenceModified -= UpdateDisplay;
			WaveManager.OnWaveUpdateMsgReceived -= OnWaveUpdateMsgReceived;
		}

		private void UpdateDisplay(Faction faction, float newValue)
		{
			if (base.Wave.TargetFaction == faction)
			{
				if (!RespawnTokensManager.TryGetNextThreshold(faction, newValue, out var threshold))
				{
					_influence.text = "MAX";
				}
				else if (_maxWavesEarned)
				{
					_influence.text = $"{newValue}/MAX";
				}
				else
				{
					_influence.text = $"{newValue}/{threshold}";
				}
			}
		}

		private void OnWaveUpdateMsgReceived(WaveUpdateMessage msg)
		{
			if (base.Wave == msg.Wave && msg.IsMax)
			{
				float num = FactionInfluenceManager.Get(base.Wave.TargetFaction);
				if (RespawnTokensManager.TryGetNextThreshold(base.Wave.TargetFaction, num, out var _))
				{
					_influence.text = $"{num}/MAX";
					_maxWavesEarned = true;
				}
			}
		}
	}
}
