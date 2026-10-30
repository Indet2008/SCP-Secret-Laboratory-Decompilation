namespace Discord.Basic
{
	public struct EventHandlers : global::System.IEquatable<global::Discord.Basic.EventHandlers>
	{
		public global::Discord.CallbackController.OnReadyInfo readyCallback;

		public global::Discord.CallbackController.OnDisconnectedInfo disconnectedCallback;

		public global::Discord.CallbackController.OnErrorInfo errorCallback;

		public global::Discord.CallbackController.OnJoinInfo joinCallback;

		public global::Discord.CallbackController.OnSpectateInfo spectateCallback;

		public global::Discord.CallbackController.OnRequestInfo requestCallback;

		public bool Equals(global::Discord.Basic.EventHandlers other)
		{
			if (object.Equals(readyCallback, other.readyCallback) && object.Equals(disconnectedCallback, other.disconnectedCallback) && object.Equals(errorCallback, other.errorCallback) && object.Equals(joinCallback, other.joinCallback) && object.Equals(spectateCallback, other.spectateCallback))
			{
				return object.Equals(requestCallback, other.requestCallback);
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj is global::Discord.Basic.EventHandlers other)
			{
				return Equals(other);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return global::System.HashCode.Combine(readyCallback, disconnectedCallback, errorCallback, joinCallback, spectateCallback, requestCallback);
		}

		public static bool operator ==(global::Discord.Basic.EventHandlers left, global::Discord.Basic.EventHandlers right)
		{
			return left.Equals(right);
		}

		public static bool operator !=(global::Discord.Basic.EventHandlers left, global::Discord.Basic.EventHandlers right)
		{
			return !left.Equals(right);
		}
	}
}
