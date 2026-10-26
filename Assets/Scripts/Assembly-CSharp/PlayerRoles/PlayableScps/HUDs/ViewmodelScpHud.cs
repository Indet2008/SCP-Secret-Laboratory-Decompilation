using UnityEngine;

namespace PlayerRoles.PlayableScps.HUDs
{
	public abstract class ViewmodelScpHud : ScpHudBase, IViewmodelRole
	{
		[field: SerializeField]
		public ScpViewmodelBase Viewmodel { get; protected set; }

		public bool TryGetViewmodelFov(out float fov)
		{
			fov = Viewmodel.CamFOV;
			return true;
		}
	}
}
