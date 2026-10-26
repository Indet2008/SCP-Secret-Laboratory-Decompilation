namespace Respawning.Graphics
{
	public class RespawningTooltips : global::UnityEngine.MonoBehaviour
	{
		[global::System.Serializable]
		private struct Tooltip
		{
			public global::UnityEngine.GameObject Key;

			public global::Respawning.Graphics.RespawnTooltipTranslation Translation;
		}

		private global::Respawning.Graphics.RespawningTooltips.Tooltip[] StoredInfo
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			get
			{
				return default;
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			set
			{
			}
		}

		protected global::Tooltips.TooltipManager TooltipManager
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			get
			{
				return default;
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			set
			{
			}
		}

		private void Start()
		{
		}

		public RespawningTooltips()
		{
		}
	}
}
