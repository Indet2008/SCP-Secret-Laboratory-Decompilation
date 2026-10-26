using System;
using InventorySystem.Items.Firearms.ShotEvents;

namespace InventorySystem.Items.Firearms.Modules
{
	[UniqueModule]
	public interface IHitregModule
	{
		float DisplayDamage { get; }

		float DisplayPenetration { get; }

		event Action ServerOnFired;

		void Fire(ReferenceHub primaryTarget, ShotEvent shotData);
	}
}
