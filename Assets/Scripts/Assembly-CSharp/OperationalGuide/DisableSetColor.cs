using UnityEngine;

namespace OperationalGuide
{
	public class DisableSetColor : MonoBehaviour
	{
		public AbilityColorChange ACC;

		private void OnDisable()
		{
			ACC.AbilityIcon.color = ACC.DefaultColor;
		}
	}
}
