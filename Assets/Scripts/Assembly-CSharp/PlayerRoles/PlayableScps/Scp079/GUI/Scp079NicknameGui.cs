using PlayerRoles.PlayableScps.Scp079.Cameras;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079NicknameGui : Scp079GuiElementBase
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Camera _cam;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RectTransform _fullscreenRect;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RectTransform _template;


		private Scp079CurrentCameraSync _camSync;

		internal override void Init(Scp079Role role, ReferenceHub owner)
		{
			base.Init(role, owner);
			role.SubroutineModule.TryGetSubroutine<Scp079CurrentCameraSync>(out _camSync);
		}
	}
}
