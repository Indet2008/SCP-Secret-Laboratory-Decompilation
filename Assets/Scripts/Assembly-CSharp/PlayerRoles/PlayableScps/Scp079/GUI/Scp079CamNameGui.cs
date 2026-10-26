using PlayerRoles.PlayableScps.Scp079.Cameras;
using TMPro;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079CamNameGui : Scp079GuiElementBase
	{
		[SerializeField]
		private TextMeshProUGUI _label;

		private Scp079CurrentCameraSync _curCamSync;

		internal override void Init(Scp079Role role, ReferenceHub owner)
		{
			base.Init(role, owner);
			role.SubroutineModule.TryGetSubroutine<Scp079CurrentCameraSync>(out _curCamSync);
		}

		private void Update()
		{
			if (_curCamSync.TryGetCurrentCamera(out var cam))
			{
				_label.text = cam.Label;
			}
		}
	}
}
