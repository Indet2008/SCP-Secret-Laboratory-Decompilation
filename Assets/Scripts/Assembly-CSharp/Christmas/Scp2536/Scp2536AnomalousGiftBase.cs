using System.Collections.Generic;

namespace Christmas.Scp2536
{
	public class Scp2536AnomalousGiftBase : Scp2536GiftBase
	{
		public static readonly List<ReferenceHub> GlobalObtainedBy = new List<ReferenceHub>();

		public override UrgencyLevel Urgency { get; }

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (!GlobalObtainedBy.Contains(hub))
			{
				return base.CanBeGranted(hub);
			}
			return false;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			GlobalObtainedBy.Add(hub);
		}

		public override void Reset()
		{
			base.Reset();
			GlobalObtainedBy.Clear();
		}
	}
}
