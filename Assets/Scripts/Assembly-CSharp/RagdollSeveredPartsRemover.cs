using System.Collections.Generic;
using CustomPlayerEffects;
using Footprinting;
using PlayerRoles.Ragdolls;
using UnityEngine;

public class RagdollSeveredPartsRemover : MonoBehaviour
{
	[SerializeField]
	private DynamicRagdoll _ragdoll;

	[SerializeField]
	private Transform[] _hands;

	[SerializeField]
	private Transform[] _eyes;

	private void Start()
	{
		if (IsRagdollAffected(SeveredHands.AllSeveredHands))
		{
			RemoveHands();
		}
		if (IsRagdollAffected(SeveredEyes.AllSeveredEyes))
		{
			RemoveEyes();
		}
	}

	// Each severed-parts footprint is consumed by the first ragdoll of its owner.
	private bool IsRagdollAffected(List<Footprint> list)
	{
		for (int i = 0; i < list.Count; i++)
		{
			Footprint footprint = list[i];
			if (!(footprint.Hub != _ragdoll.Info.OwnerHub))
			{
				list.RemoveAt(i);
				if (footprint.Hub != null)
				{
					return true;
				}
				i--;
			}
		}
		return false;
	}

	private void RemoveEyes()
	{
		Transform[] eyes = _eyes;
		for (int i = 0; i < eyes.Length; i++)
		{
			eyes[i].localScale = Vector3.zero;
		}
	}

	private void RemoveHands()
	{
		Transform[] hands = _hands;
		for (int i = 0; i < hands.Length; i++)
		{
			hands[i].localScale = Vector3.forward;
		}
	}
}
