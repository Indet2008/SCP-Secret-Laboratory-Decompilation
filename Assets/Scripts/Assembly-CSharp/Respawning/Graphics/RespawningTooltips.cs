using System;
using Tooltips;
using UnityEngine;

namespace Respawning.Graphics
{
	public class RespawningTooltips : MonoBehaviour
	{
		[Serializable]
		private struct Tooltip
		{
			public GameObject Key;

			public RespawnTooltipTranslation Translation;
		}

		[field: SerializeField]
		private Tooltip[] StoredInfo { get; set; }

		[field: SerializeField]
		protected TooltipManager TooltipManager { get; set; }

		private void Start()
		{
			Tooltip[] storedInfo = StoredInfo;
			for (int i = 0; i < storedInfo.Length; i++)
			{
				Tooltip tooltip = storedInfo[i];
				TooltipManager.StoredTips.Add(tooltip.Key, Translations.Get(tooltip.Translation));
			}
		}
	}
}
