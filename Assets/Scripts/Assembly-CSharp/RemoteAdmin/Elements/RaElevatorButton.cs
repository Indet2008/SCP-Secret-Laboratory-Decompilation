using Interactables.Interobjects;
using UnityEngine;

namespace RemoteAdmin.Elements
{
	public class RaElevatorButton : MapControlButton
	{
		public ElevatorChamber Target;

		private bool _hasTarget;

		public override void Setup()
		{
			base.Setup();
			_hasTarget = Target != null;
			if (_hasTarget)
			{
				string text = Target.AssignedGroup.ToString();
				if (base.Text != null)
				{
					base.Text.text = text;
				}
				base.Value = text + ".";
			}
			UpdateGraphics();
		}

		protected override Color BackgroundColor()
		{
			if (!_hasTarget || Target == null)
			{
				return MapControlButton.PresetColor(MapMenu.Closed, Color.gray);
			}
			return MapControlButton.PresetColor(MapMenu.Opened, Color.green);
		}

		protected override Color OutlineColor()
		{
			if (base.IsSelected)
			{
				return MapControlButton.PresetColor(MapMenu.Selected, Color.white);
			}
			return MapControlButton.PresetColor(MapMenu.Unselected, Color.gray);
		}
	}
}