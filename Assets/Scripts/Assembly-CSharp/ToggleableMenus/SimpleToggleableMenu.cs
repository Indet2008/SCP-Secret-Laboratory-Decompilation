using UnityEngine;

namespace ToggleableMenus
{
	public class SimpleToggleableMenu : ToggleableMenuBase
	{
		[SerializeField]
		private GameObject _targetRoot;

		public override bool CanToggle => true;

		protected override void OnToggled()
		{
			if (_targetRoot != null)
			{
				_targetRoot.SetActive(IsEnabled);
			}
		}
	}
}
