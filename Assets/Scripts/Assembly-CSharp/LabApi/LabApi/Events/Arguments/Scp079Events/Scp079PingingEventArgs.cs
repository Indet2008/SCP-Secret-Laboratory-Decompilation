namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079PingingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::UnityEngine.Vector3 Position { get; set; }

		public global::UnityEngine.Vector3 Normal { get; set; }

		public global::LabApi.Features.Enums.Scp079PingType PingType { get; set; }

		public bool IsAllowed { get; set; }

		public Scp079PingingEventArgs(ReferenceHub player, global::UnityEngine.Vector3 position, global::UnityEngine.Vector3 normal, byte index)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
			Position = position;
			Normal = normal;
			PingType = (global::LabApi.Features.Enums.Scp079PingType)index;
			IsAllowed = true;
		}
	}
}
