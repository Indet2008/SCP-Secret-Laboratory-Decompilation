namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerEffectUpdatingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::CustomPlayerEffects.StatusEffectBase Effect { get; }

		public byte Intensity { get; set; }

		public float Duration { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerEffectUpdatingEventArgs(ReferenceHub hub, global::CustomPlayerEffects.StatusEffectBase effect, byte intensity, float duration)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Effect = effect;
			Intensity = intensity;
			Duration = duration;
		}
	}
}
