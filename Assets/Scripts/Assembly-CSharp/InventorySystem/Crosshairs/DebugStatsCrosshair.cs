using System.Text;
using InventorySystem.Items.Firearms;
using InventorySystem.Items.Firearms.Modules;
using TMPro;
using UnityEngine;

namespace InventorySystem.Crosshairs
{
	public class DebugStatsCrosshair : FirearmCrosshairBase
	{
		[SerializeField]
		private UiCircle _circle;

		[SerializeField]
		private TMP_Text _text;

		[SerializeField]
		private float _radiusRatio;

		private readonly StringBuilder _sb = new StringBuilder();

		public static bool Enabled { get; set; }

		protected override float GetAlpha(Firearm firearm)
		{
			return 1f;
		}

		protected override void UpdateCrosshair(Firearm firearm, float currentInaccuracy)
		{
			DisplayInaccuracyValues combinedDisplayInaccuracy = IDisplayableInaccuracyProviderModule.GetCombinedDisplayInaccuracy(firearm);
			_circle.Radius = _radiusRatio * currentInaccuracy;
			_sb.Clear();
			AppendValue("Total", currentInaccuracy);
			_sb.Append("\nDisplay values\n");
			AppendValue("Hip", combinedDisplayInaccuracy.HipDeg);
			AppendValue("Running", combinedDisplayInaccuracy.RunningDeg);
			AppendValue("ADS", combinedDisplayInaccuracy.AdsDeg);
			AppendValue("Bullet", combinedDisplayInaccuracy.BulletDeg);
			_text.SetText(_sb);
		}

		private void AppendValue(string label, float accuracy)
		{
			_sb.Append(label + ": ");
			for (int i = label.Length; i < 10; i++)
			{
				_sb.Append(' ');
			}
			_sb.Append($"{accuracy:0.000}°\n");
		}
	}
}
