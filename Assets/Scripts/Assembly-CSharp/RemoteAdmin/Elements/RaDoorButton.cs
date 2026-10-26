using Interactables.Interobjects.DoorUtils;
using UnityEngine;

namespace RemoteAdmin.Elements
{
	public class RaDoorButton : MapControlButton
	{
		public DoorNametagExtension Door;

		private bool _hasTargetDoor;

		public override void Setup()
		{
			base.Setup();
			_hasTargetDoor = Door != null;
			if (_hasTargetDoor)
			{
				if (base.Text != null)
				{
					base.Text.text = Door.GetName;
				}
				base.Value = Door.GetName + ".";
			}
			UpdateGraphics();
		}

		protected override Color BackgroundColor()
		{
			DoorVariant doorVariant = (_hasTargetDoor ? Door.TargetDoor : null);
			if (doorVariant == null)
			{
				return MapControlButton.PresetColor(MapMenu.Closed, Color.gray);
			}
			if (doorVariant is IDamageableDoor { IsDestroyed: not false })
			{
				return MapControlButton.PresetColor(MapMenu.LockedUnselected, Color.red);
			}
			float exactState = doorVariant.GetExactState();
			if (exactState > 0.01f && exactState < 0.99f)
			{
				return MapControlButton.PresetColor(MapMenu.Moving, Color.yellow);
			}
			if (!doorVariant.TargetState)
			{
				return MapControlButton.PresetColor(MapMenu.Closed, Color.red);
			}
			return MapControlButton.PresetColor(MapMenu.Opened, Color.green);
		}

		protected override Color OutlineColor()
		{
			bool flag = _hasTargetDoor && Door.TargetDoor != null && Door.TargetDoor.ActiveLocks != 0;
			if (base.IsSelected)
			{
				return MapControlButton.PresetColor(flag ? MapMenu.LockedSelected : MapMenu.Selected, Color.white);
			}
			return MapControlButton.PresetColor(flag ? MapMenu.LockedUnselected : MapMenu.Unselected, Color.gray);
		}
	}
}