namespace InventorySystem.Items.Scp1509
{
	public enum Scp1509MessageType
	{
		Holstered = 0,
		AttackTriggered = 1,
		AttackPreformedHitWall = 2,
		AttackPreformedHitFlesh = 3,
		AttackPreformedHitMissed = 4,
		SpawnResurrectParticles = 5,
		AttackPerformed = 6,
		Inspect = 7,
		CanResurrect = 8,
		CanNotResurrect = 9,
		KilledPlayer = 10,
		NewPlayerFullResync = 11
	}
}
