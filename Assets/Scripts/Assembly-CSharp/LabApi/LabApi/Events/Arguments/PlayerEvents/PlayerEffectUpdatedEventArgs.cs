namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerEffectUpdatedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::CustomPlayerEffects.StatusEffectBase Effect { get; }

		public byte Intensity { get; }

		public float Duration { get; }

		public PlayerEffectUpdatedEventArgs(ReferenceHub hub, global::CustomPlayerEffects.StatusEffectBase effect, byte intensity, float duration)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Effect = effect;
			Intensity = intensity;
			Duration = duration;
		}
	}
}
