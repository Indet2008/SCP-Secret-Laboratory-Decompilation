using System;
using CustomPlayerEffects;
using Mirror;
using UnityEngine;

public class PitKiller : MonoBehaviour
{
	public event Action<ReferenceHub> OnEffectApplied;

	private void OnTriggerEnter(Collider other)
	{
		if (NetworkServer.active && ReferenceHub.TryGetHub(other.transform.root.gameObject, out var hub) && PitDeath.ValidatePlayer(hub))
		{
			PitDeath effect = hub.playerEffectsController.GetEffect<PitDeath>();
			if (!effect.IsEnabled)
			{
				OnEffectApplied?.Invoke(hub);
				effect.IsEnabled = true;
			}
		}
	}
}
