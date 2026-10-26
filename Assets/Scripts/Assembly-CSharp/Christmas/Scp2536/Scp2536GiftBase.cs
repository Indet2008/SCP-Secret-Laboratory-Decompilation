using System.Collections.Generic;

namespace Christmas.Scp2536
{
	public abstract class Scp2536GiftBase
	{
		public readonly HashSet<ReferenceHub> ObtainedBy = new HashSet<ReferenceHub>();

		public abstract UrgencyLevel Urgency { get; }

		internal virtual bool IgnoredByRandomness => false;

		public virtual bool CanBeGranted(ReferenceHub hub)
		{
			return !ObtainedBy.Contains(hub);
		}

		public abstract void ServerGrant(ReferenceHub hub);

		public virtual void Reset()
		{
			ObtainedBy.Clear();
		}
	}
}
