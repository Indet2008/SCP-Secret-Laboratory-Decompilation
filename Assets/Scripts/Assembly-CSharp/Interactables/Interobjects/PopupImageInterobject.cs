using UnityEngine;

namespace Interactables.Interobjects
{
	public class PopupImageInterobject : PopupInterobject
	{
		public Sprite ImageToDisplay;

		public Vector2 Resolution;

		private static UserMainInterface UserGUI => UserMainInterface.singleton;

		protected override void OnClientStateChange()
		{
			if (PopupInterobject.CurrentState == PopupState.Enabling)
			{
				PopupInterobject.TrackedPosition = base.transform.position;
			}
		}

		protected override void OnClientUpdate(float enableRatio)
		{
			UserMainInterface.singleton.imageDisplayGroup.alpha = enableRatio;
		}
	}
}
