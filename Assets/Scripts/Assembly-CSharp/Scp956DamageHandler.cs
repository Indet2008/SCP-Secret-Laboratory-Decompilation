using InventorySystem;
using InventorySystem.Items.Pickups;
using InventorySystem.Items.Usables.Scp330;
using Mirror;
using PlayerStatsSystem;
using UnityEngine;

public class Scp956DamageHandler : StandardDamageHandler
{
	private readonly Vector3 _velocity;

	public override string RagdollInspectText => "Blunt force trauma and a ruptured torso suggest a death by SCP-956.";

	public override string DeathScreenText => "Bludgeoned by SCP-956.";

	public override string ServerLogsText => "Died to SCP-956";

	public override CassieAnnouncement CassieDeathAnnouncement => null;

	public override float Damage { get; set; }

	public Scp956DamageHandler(Vector3 direction)
	{
		_velocity = (direction * 3f + Vector3.up) * 9f;
		Damage = -1f;
	}

	public override HandlerOutput ApplyDamage(ReferenceHub ply)
	{
		HandlerOutput handlerOutput = base.ApplyDamage(ply);
		if (handlerOutput != HandlerOutput.Death)
		{
			return handlerOutput;
		}
		if (!InventoryItemLoader.TryGetItem<Scp330Bag>(ItemType.SCP330, out var result))
		{
			return handlerOutput;
		}
		int num = ((Random.value < 0.1f) ? 1 : 0);
		for (int i = 0; i < 20; i++)
		{
			Scp330Pickup scp330Pickup = InventoryExtensions.ServerCreatePickup(psi: new PickupSyncInfo(ItemType.SCP330, result.Weight, 0), inv: ply.inventory, item: result) as Scp330Pickup;
			if (!(scp330Pickup == null))
			{
				CandyKindID candyKindID = ((num-- > 0) ? CandyKindID.Pink : ((CandyKindID)Random.Range(1, 7)));
				scp330Pickup.StoredCandies.Add(candyKindID);
				scp330Pickup.NetworkExposedCandy = candyKindID;
				if (scp330Pickup.TryGetComponent<Rigidbody>(out var component))
				{
					component.linearVelocity = _velocity;
				}
			}
		}
		return handlerOutput;
	}

	public override void WriteAdditionalData(NetworkWriter writer)
	{
		StartVelocity = _velocity;
		base.WriteAdditionalData(writer);
	}
}
