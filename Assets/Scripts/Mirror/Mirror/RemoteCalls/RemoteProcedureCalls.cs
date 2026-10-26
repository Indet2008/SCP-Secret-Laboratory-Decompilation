namespace Mirror.RemoteCalls
{
	public static class RemoteProcedureCalls
	{
		private static readonly global::System.Collections.Generic.Dictionary<ushort, global::Mirror.RemoteCalls.Invoker> remoteCallDelegates = new global::System.Collections.Generic.Dictionary<ushort, global::Mirror.RemoteCalls.Invoker>();

		private static bool CheckIfDelegateExists(global::System.Type componentType, global::Mirror.RemoteCalls.RemoteCallType remoteCallType, global::Mirror.RemoteCalls.RemoteCallDelegate func, ushort functionHash)
		{
			if (remoteCallDelegates.ContainsKey(functionHash))
			{
				global::Mirror.RemoteCalls.Invoker invoker = remoteCallDelegates[functionHash];
				if (invoker.AreEqual(componentType, remoteCallType, func))
				{
					return true;
				}
				global::UnityEngine.Debug.LogError($"Function {invoker.componentType}.{invoker.function.GetMethodName()} and {componentType}.{func.GetMethodName()} have the same hash. Please rename one of them. To save bandwidth, we only use 2 bytes for the hash, which has a small chance of collisions.");
			}
			return false;
		}

		internal static ushort RegisterDelegate(global::System.Type componentType, string functionFullName, global::Mirror.RemoteCalls.RemoteCallType remoteCallType, global::Mirror.RemoteCalls.RemoteCallDelegate func, bool cmdRequiresAuthority = true)
		{
			ushort num = (ushort)(functionFullName.GetStableHashCode() & 0xFFFF);
			if (CheckIfDelegateExists(componentType, remoteCallType, func, num))
			{
				return num;
			}
			remoteCallDelegates[num] = new global::Mirror.RemoteCalls.Invoker
			{
				callType = remoteCallType,
				componentType = componentType,
				function = func,
				cmdRequiresAuthority = cmdRequiresAuthority
			};
			return num;
		}

		public static void RegisterCommand(global::System.Type componentType, string functionFullName, global::Mirror.RemoteCalls.RemoteCallDelegate func, bool requiresAuthority)
		{
			RegisterDelegate(componentType, functionFullName, global::Mirror.RemoteCalls.RemoteCallType.Command, func, requiresAuthority);
		}

		public static void RegisterRpc(global::System.Type componentType, string functionFullName, global::Mirror.RemoteCalls.RemoteCallDelegate func)
		{
			RegisterDelegate(componentType, functionFullName, global::Mirror.RemoteCalls.RemoteCallType.ClientRpc, func);
		}

		internal static void RemoveDelegate(ushort hash)
		{
			remoteCallDelegates.Remove(hash);
		}

		private static bool GetInvokerForHash(ushort functionHash, global::Mirror.RemoteCalls.RemoteCallType remoteCallType, out global::Mirror.RemoteCalls.Invoker invoker)
		{
			if (remoteCallDelegates.TryGetValue(functionHash, out invoker) && invoker != null)
			{
				return invoker.callType == remoteCallType;
			}
			return false;
		}

		internal static bool Invoke(ushort functionHash, global::Mirror.RemoteCalls.RemoteCallType remoteCallType, global::Mirror.NetworkReader reader, global::Mirror.NetworkBehaviour component, global::Mirror.NetworkConnectionToClient senderConnection = null)
		{
			if (GetInvokerForHash(functionHash, remoteCallType, out var invoker) && invoker.componentType.IsInstanceOfType(component))
			{
				invoker.function(component, reader, senderConnection);
				return true;
			}
			return false;
		}

		internal static bool CommandRequiresAuthority(ushort cmdHash)
		{
			if (GetInvokerForHash(cmdHash, global::Mirror.RemoteCalls.RemoteCallType.Command, out var invoker))
			{
				return invoker.cmdRequiresAuthority;
			}
			return false;
		}

		public static global::Mirror.RemoteCalls.RemoteCallDelegate GetDelegate(ushort functionHash)
		{
			if (!remoteCallDelegates.TryGetValue(functionHash, out var value))
			{
				return null;
			}
			return value.function;
		}
	}
}
