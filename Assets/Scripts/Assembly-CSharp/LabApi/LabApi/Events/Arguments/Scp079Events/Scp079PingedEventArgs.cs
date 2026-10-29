namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079PingedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::UnityEngine.Vector3 Position { get; }

		public global::UnityEngine.Vector3 Normal { get; }

		public global::LabApi.Features.Enums.Scp079PingType PingType { get; }

		public Scp079PingedEventArgs(ReferenceHub player, global::UnityEngine.Vector3 position, global::UnityEngine.Vector3 normal, byte index)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
			Position = position;
			Normal = normal;
			PingType = (global::LabApi.Features.Enums.Scp079PingType)index;
		}
	}
}
