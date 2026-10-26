using Hazards;
using PlayerRoles;
using RelativePositioning;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp330
{
	public class HauntedCandyBrown : ICandy
	{
		private const float RayMaxDistance = 3f;

		private const float TantrumHeight = 1.25f;

		private const float ObjectOffset = 0.5f;

		private const float SourceOffset = 1.5f;

		private static readonly CachedLayerMask DetectionMask = new CachedLayerMask("Default");

		public CandyKindID Kind => CandyKindID.Brown;

		public float SpawnChanceWeight { get; private set; }

		public void ServerApplyEffects(ReferenceHub hub)
		{
			if (!Scp330Bag.TryGetBag(hub, out var bag) || !(hub.roleManager.CurrentRole is HumanRole humanRole) || !Physics.Raycast(humanRole.FpcModule.Position, Vector3.down, out var hitInfo, 3f, DetectionMask))
			{
				return;
			}
			Vector3 vector = -hub.gameObject.transform.forward;
			Vector3 vector2 = hitInfo.point + Vector3.up * 1.25f + vector * 0.5f;
			Quaternion rotation = Quaternion.LookRotation(vector);
			TantrumEnvironmentalHazard tantrumEnvironmentalHazard = Object.Instantiate(bag.TantrumPrefab, vector2, rotation);
			tantrumEnvironmentalHazard.SynchronizedPosition = new RelativePosition(vector2);
			tantrumEnvironmentalHazard.SourceOffset += vector * 1.5f;
			foreach (TeslaGate allGate in TeslaGate.AllGates)
			{
				if (allGate.IsInIdleRange(hub))
				{
					allGate.TantrumsToBeDestroyed.Add(tantrumEnvironmentalHazard);
				}
			}
		}
	}
}
