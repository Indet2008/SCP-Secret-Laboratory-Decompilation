namespace Mirror
{
	public static class NetworkLoop
	{
		internal enum AddMode
		{
			Beginning = 0,
			End = 1
		}

		public static global::System.Action OnEarlyUpdate;

		public static global::System.Action OnLateUpdate;

		[global::UnityEngine.RuntimeInitializeOnLoadMethod(global::UnityEngine.RuntimeInitializeLoadType.BeforeSceneLoad)]
		private static void ResetStatics()
		{
			OnEarlyUpdate = null;
			OnLateUpdate = null;
		}

		internal static int FindPlayerLoopEntryIndex(global::UnityEngine.LowLevel.PlayerLoopSystem.UpdateFunction function, global::UnityEngine.LowLevel.PlayerLoopSystem playerLoop, global::System.Type playerLoopSystemType)
		{
			if (playerLoop.type == playerLoopSystemType)
			{
				return global::System.Array.FindIndex(playerLoop.subSystemList, (global::UnityEngine.LowLevel.PlayerLoopSystem elem) => elem.updateDelegate == function);
			}
			if (playerLoop.subSystemList != null)
			{
				for (int num = 0; num < playerLoop.subSystemList.Length; num++)
				{
					int num2 = FindPlayerLoopEntryIndex(function, playerLoop.subSystemList[num], playerLoopSystemType);
					if (num2 != -1)
					{
						return num2;
					}
				}
			}
			return -1;
		}

		internal static bool AddToPlayerLoop(global::UnityEngine.LowLevel.PlayerLoopSystem.UpdateFunction function, global::System.Type ownerType, ref global::UnityEngine.LowLevel.PlayerLoopSystem playerLoop, global::System.Type playerLoopSystemType, global::Mirror.NetworkLoop.AddMode addMode)
		{
			if (playerLoop.type == playerLoopSystemType)
			{
				if (global::System.Array.FindIndex(playerLoop.subSystemList, (global::UnityEngine.LowLevel.PlayerLoopSystem s) => s.updateDelegate == function) != -1)
				{
					return true;
				}
				int num = ((playerLoop.subSystemList != null) ? playerLoop.subSystemList.Length : 0);
				global::System.Array.Resize(ref playerLoop.subSystemList, num + 1);
				global::UnityEngine.LowLevel.PlayerLoopSystem playerLoopSystem = new global::UnityEngine.LowLevel.PlayerLoopSystem
				{
					type = ownerType,
					updateDelegate = function
				};
				switch (addMode)
				{
				case global::Mirror.NetworkLoop.AddMode.Beginning:
					global::System.Array.Copy(playerLoop.subSystemList, 0, playerLoop.subSystemList, 1, playerLoop.subSystemList.Length - 1);
					playerLoop.subSystemList[0] = playerLoopSystem;
					break;
				case global::Mirror.NetworkLoop.AddMode.End:
					playerLoop.subSystemList[num] = playerLoopSystem;
					break;
				}
				return true;
			}
			if (playerLoop.subSystemList != null)
			{
				for (int num2 = 0; num2 < playerLoop.subSystemList.Length; num2++)
				{
					if (AddToPlayerLoop(function, ownerType, ref playerLoop.subSystemList[num2], playerLoopSystemType, addMode))
					{
						return true;
					}
				}
			}
			return false;
		}

		[global::UnityEngine.RuntimeInitializeOnLoadMethod(global::UnityEngine.RuntimeInitializeLoadType.BeforeSceneLoad)]
		private static void RuntimeInitializeOnLoad()
		{
			global::UnityEngine.LowLevel.PlayerLoopSystem playerLoop = global::UnityEngine.LowLevel.PlayerLoop.GetCurrentPlayerLoop();
			AddToPlayerLoop(NetworkEarlyUpdate, typeof(global::Mirror.NetworkLoop), ref playerLoop, typeof(global::UnityEngine.PlayerLoop.EarlyUpdate), global::Mirror.NetworkLoop.AddMode.End);
			AddToPlayerLoop(NetworkLateUpdate, typeof(global::Mirror.NetworkLoop), ref playerLoop, typeof(global::UnityEngine.PlayerLoop.PreLateUpdate), global::Mirror.NetworkLoop.AddMode.End);
			global::UnityEngine.LowLevel.PlayerLoop.SetPlayerLoop(playerLoop);
		}

		private static void NetworkEarlyUpdate()
		{
			if (global::UnityEngine.Application.isPlaying)
			{
				global::Mirror.NetworkServer.NetworkEarlyUpdate();
				global::Mirror.NetworkClient.NetworkEarlyUpdate();
				OnEarlyUpdate?.Invoke();
			}
		}

		private static void NetworkLateUpdate()
		{
			if (global::UnityEngine.Application.isPlaying)
			{
				OnLateUpdate?.Invoke();
				global::Mirror.NetworkServer.NetworkLateUpdate();
				global::Mirror.NetworkClient.NetworkLateUpdate();
			}
		}
	}
}
