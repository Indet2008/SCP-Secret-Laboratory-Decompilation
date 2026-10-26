using TMPro;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class TranslatedLabelDetail : DetailBase
	{
		public enum KeycardLabelTranslation
		{
			Scientist = 0,
			Janitor = 1,
			ResearchSupervisor = 2,
			ContEngineer = 3,
			SecurityGuard = 4,
			ZoneManager = 5,
			FacilityManager = 6,
			SurfaceAccessPassNormal = 7,
			SurfaceAccessPassUsed = 8
		}

		[SerializeField]
		private KeycardLabelTranslation _translation;

		[SerializeField]
		private Color _textColor;

		public override void ApplyDetail(KeycardGfx gfxTarget, KeycardItem template)
		{
			string text = Translations.Get(_translation);
			TMP_Text[] keycardLabels = gfxTarget.KeycardLabels;
			foreach (TMP_Text obj in keycardLabels)
			{
				obj.text = text;
				obj.color = _textColor;
			}
		}
	}
}
