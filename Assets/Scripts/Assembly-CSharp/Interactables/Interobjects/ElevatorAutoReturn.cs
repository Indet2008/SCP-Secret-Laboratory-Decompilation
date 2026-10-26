using Mirror;
using UnityEngine;

namespace Interactables.Interobjects
{
	public class ElevatorAutoReturn : MonoBehaviour
	{
		private static readonly float TopIdleDurationThresholdSeconds = 5f;

		private ElevatorChamber _chamber;

		private void Start()
		{
			if (NetworkServer.active)
			{
				_chamber = GetComponent<ElevatorChamber>();
				_chamber.ServerSetDestination(0, allowQueueing: false);
			}
		}

		private void Update()
		{
			if (NetworkServer.active && _chamber.CurSequence == ElevatorChamber.ElevatorSequence.Ready && _chamber.GoingUp && !(_chamber.SequenceElapsed < TopIdleDurationThresholdSeconds) && _chamber.DestinationDoor.ActiveLocks == 0)
			{
				_chamber.ServerSetDestination(_chamber.NextLevel, allowQueueing: false);
			}
		}
	}
}
