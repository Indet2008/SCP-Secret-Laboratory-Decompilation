using Mirror;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers
{
	public interface INetworkedAnimatedModelSubcontroller : IAnimatedModelSubcontroller
	{
		void ProcessRpc(NetworkReader reader);
	}
}
