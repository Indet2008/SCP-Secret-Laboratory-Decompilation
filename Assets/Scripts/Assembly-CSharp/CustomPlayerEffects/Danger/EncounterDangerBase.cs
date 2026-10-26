namespace CustomPlayerEffects.Danger
{
	public abstract class EncounterDangerBase : ParentDangerBase
	{
		public abstract float DangerPerEncounter { get; }

		public abstract float DangerPerAdditionalEncounter { get; }

		public void RegisterEncounter(ReferenceHub target)
		{
			float dangerValue = (base.ChildDangers.IsEmpty() ? DangerPerEncounter : DangerPerAdditionalEncounter);
			base.ChildDangers.Add(new CachedEncounterDanger(dangerValue, base.Owner, target));
		}

		public bool WasEncounteredRecently(ReferenceHub hub, out CachedEncounterDanger cachedEncounter)
		{
			cachedEncounter = null;
			foreach (CachedEncounterDanger childDanger in base.ChildDangers)
			{
				if (!(childDanger.EncounteredHub != hub))
				{
					cachedEncounter = childDanger;
					return true;
				}
			}
			return false;
		}
	}
}
