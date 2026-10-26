using Mirror;
using UnityEngine;

namespace PlayerRoles.Subroutines
{
	public class SubroutineManagerModule : MonoBehaviour
	{
		public SubroutineBase[] AllSubroutines;

		private void OnValidate()
		{
			AllSubroutines = GetComponentsInChildren<SubroutineBase>();
		}

		public bool TryGetSubroutine<T>(out T subroutine) where T : SubroutineBase
		{
			for (int i = 0; i < AllSubroutines.Length; i++)
			{
				if (AllSubroutines[i] is T val)
				{
					subroutine = val;
					return true;
				}
			}
			subroutine = null;
			return false;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkServer.ReplaceHandler((NetworkConnectionToClient conn, SubroutineMessage msg) =>
				{
					msg.ServerApplyTrigger(conn);
				});
				NetworkClient.ReplaceHandler((NetworkConnection conn, SubroutineMessage msg) =>
				{
					msg.ClientApplyConfirmation();
				});
			};
		}
	}
}
