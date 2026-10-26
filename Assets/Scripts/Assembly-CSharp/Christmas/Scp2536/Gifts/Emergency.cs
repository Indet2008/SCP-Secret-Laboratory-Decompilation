using System.Collections.Generic;
using CustomPlayerEffects;
using MapGeneration;
using PlayerRoles.PlayableScps.Scp096;
using UnityEngine;

namespace Christmas.Scp2536.Gifts
{
	public class Emergency : Scp2536ItemGift
	{
		private static readonly Dictionary<int, float> TargetTracker = new Dictionary<int, float>();

		private const float Scp096TargetPersistanceDuration = 30f;

		public override UrgencyLevel Urgency => UrgencyLevel.Three;

		protected override Scp2536Reward[] Rewards => new Scp2536Reward[2]
		{
			new Scp2536Reward(ItemType.SCP500, 100f),
			new Scp2536Reward(ItemType.SCP207, 100f)
		};

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (!base.CanBeGranted(hub))
			{
				return false;
			}
			if (hub.playerEffectsController.GetEffect<CardiacArrest>().IsEnabled)
			{
				return true;
			}
			if (hub.playerEffectsController.GetEffect<Corroding>().IsEnabled)
			{
				return true;
			}
			int uniqueLifeIdentifier = hub.roleManager.CurrentRole.UniqueLifeIdentifier;
			if (TargetTracker.TryGetValue(uniqueLifeIdentifier, out var value) && Time.time <= value)
			{
				return true;
			}
			if (AlphaWarheadController.InProgress)
			{
				return hub.GetCurrentZone() != FacilityZone.Surface;
			}
			return false;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			GrantAllRewards(hub);
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			Scp096TargetsTracker.OnTargetAdded += OnTargetAdded;
		}

		private static void OnTargetAdded(ReferenceHub scp096, ReferenceHub target)
		{
			int uniqueLifeIdentifier = target.roleManager.CurrentRole.UniqueLifeIdentifier;
			TargetTracker[uniqueLifeIdentifier] = Time.time + 30f;
		}
	}
}
