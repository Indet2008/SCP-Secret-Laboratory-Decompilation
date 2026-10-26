using System;
using PlayerRoles;
using Respawning.Objectives;
using TMPro;
using UnityEngine;

namespace RemoteAdmin
{
	public class RespawnWaveInfo : MonoBehaviour
	{
		[SerializeField]
		private Faction _targetFaction;

		[SerializeField]
		private TextMeshProUGUI _respawnTokensText;

		[SerializeField]
		private TextMeshProUGUI _influenceText;

		[SerializeField]
		private TextMeshProUGUI _timeLeftText;

		private string _textColor => _targetFaction.GetFactionColor();

		public void SetData(int respawnTokens, int influence, int influenceMax, float timeLeft, bool forcePaused)
		{
			_respawnTokensText.SetText($"<color={_textColor}>{respawnTokens}");
			_influenceText.SetText($"<color={_textColor}>{influence}/{influenceMax}");
			_timeLeftText.SetText("<color=" + _textColor + ">" + TimeSpan.FromSeconds(timeLeft).ToString("mm\\:ss") + " <color=#FF0000>" + (forcePaused ? "PAUSED" : ""));
		}
	}
}
