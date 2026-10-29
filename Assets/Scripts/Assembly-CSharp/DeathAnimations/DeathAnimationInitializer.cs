using PlayerRoles.Ragdolls;
using UnityEngine;

namespace DeathAnimations
{
	public static class DeathAnimationInitializer
	{
		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			RagdollManager.OnRagdollSpawned += HandleAddedRagdoll;
			RagdollManager.OnRagdollRemoved += HandleRemovedRagdoll;
		}

		private static void HandleAddedRagdoll(BasicRagdoll rg)
		{
			DeathAnimation[] allDeathAnimations = rg.AllDeathAnimations;
			for (int i = 0; i < allDeathAnimations.Length; i++)
			{
				allDeathAnimations[i].StartDeathAnimation(rg);
			}
		}

		private static void HandleRemovedRagdoll(BasicRagdoll rg)
		{
			DeathAnimation[] allDeathAnimations = rg.AllDeathAnimations;
			for (int i = 0; i < allDeathAnimations.Length; i++)
			{
				allDeathAnimations[i].KillDeathAnimation();
			}
		}
	}
}
