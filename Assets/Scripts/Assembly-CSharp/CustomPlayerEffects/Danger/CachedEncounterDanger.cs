namespace CustomPlayerEffects.Danger
{
	public class CachedEncounterDanger : ExpiringDanger
	{
		public ReferenceHub EncounteredHub { get; private set; }

		public CachedEncounterDanger(float dangerValue, ReferenceHub owner, ReferenceHub target)
			: base(dangerValue, owner)
		{
			EncounteredHub = target;
		}
	}
}
