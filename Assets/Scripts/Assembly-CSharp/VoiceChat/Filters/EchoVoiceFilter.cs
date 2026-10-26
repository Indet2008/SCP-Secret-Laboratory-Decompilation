using CustomPlayerEffects;
using UnityEngine;

namespace VoiceChat.Filters
{
	public class EchoVoiceFilter : VoiceFilterBase<WhiteCandy>
	{
		[SerializeField]
		private AudioReverbFilter[] _targetFilters;

		protected override void SetFilters(byte oldIntensity, byte newIntensity)
		{
			AudioReverbFilter[] targetFilters = _targetFilters;
			for (int i = 0; i < targetFilters.Length; i++)
			{
				targetFilters[i].enabled = newIntensity > 0;
			}
		}
	}
}
