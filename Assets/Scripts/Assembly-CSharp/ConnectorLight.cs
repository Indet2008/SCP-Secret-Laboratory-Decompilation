using System.Collections.Generic;
using Interactables.Interobjects;
using MapGeneration;
using UnityEngine;
using Utils.NonAllocLINQ;

public class ConnectorLight : MonoBehaviour
{
	[SerializeField]
	private GameObject[] _objectsToDisable;

	private IRoomConnector _roomConnector;

	private readonly List<RoomLightController> _lightControllers = new List<RoomLightController>();

	private void Awake()
	{
		_roomConnector = GetComponent<IRoomConnector>();
		if (_roomConnector.RoomsAlreadyRegistered)
		{
			FindControllers();
		}
		else
		{
			_roomConnector.OnRoomsRegistered += FindControllers;
		}
	}

	private void FindControllers()
	{
		RoomIdentifier[] rooms = _roomConnector.Rooms;
		foreach (RoomLightController instance in RoomLightController.Instances)
		{
			if (rooms.Contains(instance.Room))
			{
				_lightControllers.Add(instance);
				instance.OnLightsSet += OnAnyUpdated;
			}
		}
	}

	private void OnAnyUpdated(bool _)
	{
		bool active = _lightControllers.Any((RoomLightController x) => x.LightsEnabled);
		GameObject[] objectsToDisable = _objectsToDisable;
		foreach (GameObject gameObject in objectsToDisable)
		{
			if (!(gameObject == null))
			{
				gameObject.SetActive(active);
			}
		}
	}
}
