using UnityEngine;

namespace Tooltips
{
	// Client-only in v14 (shell in the server build): registers its authored tips with the manager.
	public class CustomTooltipData : MonoBehaviour, ITooltipHolder
	{
		[field: SerializeField]
		public TooltipData[] StoredInfo { get; set; }

		[field: SerializeField]
		public TooltipManager Manager { get; set; }

		private void Awake()
		{
			if (Manager == null || StoredInfo == null)
			{
				return;
			}
			foreach (TooltipData tooltipData in StoredInfo)
			{
				if (tooltipData.Key != null)
				{
					Manager.StoredTips[tooltipData.Key] = tooltipData.Text;
				}
			}
		}
	}
}
