using PlayerRoles.PlayableScps.Scp079.Cameras;
using PlayerRoles.Spectating;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079SpectatableModule : SpectatableModuleBase
	{
		private Scp079Role Scp079 => base.MainRole as Scp079Role;

		public override Vector3 CameraPosition => Scp079.CameraPosition;

		public override Vector3 CameraRotation
		{
			get
			{
				Scp079Camera currentCamera = Scp079.CurrentCamera;
				return new Vector3(currentCamera.VerticalRotation, currentCamera.HorizontalRotation, currentCamera.RollRotation);
			}
		}
	}
}
