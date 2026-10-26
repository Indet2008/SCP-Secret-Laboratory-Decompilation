namespace Mirror.RemoteCalls
{
	internal class Invoker
	{
		public global::System.Type componentType;

		public global::Mirror.RemoteCalls.RemoteCallType callType;

		public global::Mirror.RemoteCalls.RemoteCallDelegate function;

		public bool cmdRequiresAuthority;

		public bool AreEqual(global::System.Type componentType, global::Mirror.RemoteCalls.RemoteCallType remoteCallType, global::Mirror.RemoteCalls.RemoteCallDelegate invokeFunction)
		{
			if (this.componentType == componentType && callType == remoteCallType)
			{
				return function == invokeFunction;
			}
			return false;
		}
	}
}
