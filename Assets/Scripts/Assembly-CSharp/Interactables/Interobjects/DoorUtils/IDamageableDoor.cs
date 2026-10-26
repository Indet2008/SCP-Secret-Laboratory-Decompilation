using System;
using Footprinting;

namespace Interactables.Interobjects.DoorUtils
{
	public interface IDamageableDoor
	{
		bool IsDestroyed { get; set; }

		float MaxHealth { get; }

		float RemainingHealth { get; }

		event Action OnDestroyedChanged;

		bool ServerDamage(float hp, DoorDamageType type, Footprint attacker = default(Footprint));

		bool ServerRepair();

		void ClientDestroyEffects();

		void ClientRepairEffects();

		float GetHealthPercent();
	}
}
