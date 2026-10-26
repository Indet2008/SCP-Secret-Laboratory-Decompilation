using System.Collections.Generic;
using MapGeneration;
using Mirror;
using UnityEngine;

public class Scp559Spawnpoint : MonoBehaviour
{
	public const float PedestalHeight = 1.042f;

	public static readonly Dictionary<RoomIdentifier, Scp559Spawnpoint> InstancesPerRoom = new Dictionary<RoomIdentifier, Scp559Spawnpoint>();

	public RoomIdentifier Room { get; private set; }

	[field: SerializeField]
	public bool HidePedestal { get; private set; }

	private void Start()
	{
		if (NetworkServer.active)
		{
			Room = GetComponentInParent<RoomIdentifier>();
			InstancesPerRoom.Add(Room, this);
		}
	}

	private void OnDestroy()
	{
		if ((object)Room != null)
		{
			InstancesPerRoom.Remove(Room);
		}
	}
}
