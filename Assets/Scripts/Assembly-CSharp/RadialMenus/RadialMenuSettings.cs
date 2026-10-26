using UnityEngine;

namespace RadialMenus
{
	[CreateAssetMenu(fileName = "New Radial Menu Preset", menuName = "ScriptableObject/Radial Menus/Settings Preset")]
	public class RadialMenuSettings : ScriptableObject
	{
		public Sprite[] MainRings;

		public Sprite[] HighlightTemplates;
	}
}
