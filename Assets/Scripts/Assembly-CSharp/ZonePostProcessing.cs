using System;
using MapGeneration;
using UnityEngine;
using UnityEngine.Rendering;
using Utils.NonAllocLINQ;

public class ZonePostProcessing : MonoBehaviour
{
	[Serializable]
	private struct ZoneVolumePair
	{
		public FacilityZone Zone;

		[SerializeField]
		private Volume _volume;

		public void SetWeight(float weight)
		{
			if (weight > 0f)
			{
				_volume.enabled = true;
				_volume.weight = Mathf.Clamp01(weight);
			}
			else
			{
				_volume.enabled = false;
			}
		}
	}

	[SerializeField]
	private ZoneVolumePair[] _zoneVols;

	[SerializeField]
	private RoomName[] _excludedRooms;

	[SerializeField]
	private float _maxTransitionDis;

	[SerializeField]
	private float _heightMultiplier;

	private bool _initalized;

	private bool[] _boundsSet;

	private Bounds[] _boundsPerZone;

	private Bounds _lastBounds;

	private FacilityZone _lastZone;

	private RoomIdentifier _lastDetectedRoom;

	private RoomIdentifier _lastWhitelistedRoom;

	private FacilityZone[] _whitelistedZones;

	private Vector3 _boundsSize;

	private void Start()
	{
		SeedSynchronizer.OnGenerationFinished += Initalize;
		if (SeedSynchronizer.MapGenerated)
		{
			Initalize();
		}
	}

	private void OnDestroy()
	{
		SeedSynchronizer.OnGenerationFinished -= Initalize;
		MainCameraController.OnUpdated -= UpdateWeights;
	}

	private void UpdateWeights()
	{
		Vector3 lastPosition = MainCameraController.LastPosition;
		if (lastPosition.TryGetRoom(out var room) && room != _lastDetectedRoom)
		{
			if (CheckWhitelisted(room))
			{
				_lastWhitelistedRoom = room;
				_lastBounds = GetRoomBounds(room);
				_lastZone = room.Zone;
			}
			_lastDetectedRoom = room;
		}
		ZoneVolumePair[] zoneVols;
		if (_lastWhitelistedRoom == room)
		{
			zoneVols = _zoneVols;
			for (int i = 0; i < zoneVols.Length; i++)
			{
				ZoneVolumePair zoneVolumePair = zoneVols[i];
				zoneVolumePair.SetWeight((zoneVolumePair.Zone == _lastZone) ? 1 : 0);
			}
			return;
		}
		FacilityZone facilityZone = FacilityZone.None;
		float num = _maxTransitionDis * _maxTransitionDis;
		zoneVols = _zoneVols;
		for (int i = 0; i < zoneVols.Length; i++)
		{
			ZoneVolumePair zoneVolumePair2 = zoneVols[i];
			if (zoneVolumePair2.Zone != _lastZone)
			{
				float num2 = _boundsPerZone[(int)zoneVolumePair2.Zone].SqrDistance(lastPosition);
				if (!(num2 >= num))
				{
					facilityZone = zoneVolumePair2.Zone;
					num = num2;
				}
			}
		}
		if (facilityZone == FacilityZone.None)
		{
			return;
		}
		float num3 = Mathf.Sqrt(num);
		float num4 = Mathf.Sqrt(_lastBounds.SqrDistance(lastPosition));
		float num5 = Mathf.Min(_maxTransitionDis, num3 + num4);
		float num6 = Mathf.Clamp01(num3 / num5);
		zoneVols = _zoneVols;
		for (int i = 0; i < zoneVols.Length; i++)
		{
			ZoneVolumePair zoneVolumePair3 = zoneVols[i];
			if (zoneVolumePair3.Zone == _lastZone)
			{
				zoneVolumePair3.SetWeight(num6);
			}
			else if (zoneVolumePair3.Zone == facilityZone)
			{
				zoneVolumePair3.SetWeight(1f - num6);
			}
			else
			{
				zoneVolumePair3.SetWeight(0f);
			}
		}
	}

	private void Initalize()
	{
		if (!_initalized)
		{
			_initalized = true;
			_whitelistedZones = new FacilityZone[_zoneVols.Length];
			for (int i = 0; i < _zoneVols.Length; i++)
			{
				_whitelistedZones[i] = _zoneVols[i].Zone;
			}
			GenerateZoneBounds();
			MainCameraController.OnUpdated += UpdateWeights;
		}
	}

	private void GenerateZoneBounds()
	{
		int maxValue = 0;
		_zoneVols.ForEach((ZoneVolumePair x) =>
		{
			maxValue = Mathf.Max(maxValue, (int)x.Zone);
		});
		int num = maxValue + 1;
		_boundsSet = new bool[num];
		_boundsPerZone = new Bounds[num];
		_boundsSize = Vector3.Scale(RoomIdentifier.GridScale, new Vector3(1f, _heightMultiplier, 1f));
		RoomIdentifier.AllRoomIdentifiers.ForEach(AddRoomToBounds);
	}

	private void AddRoomToBounds(RoomIdentifier room)
	{
		if (CheckWhitelisted(room))
		{
			int zone = (int)room.Zone;
			Bounds roomBounds = GetRoomBounds(room);
			if (_boundsSet[zone])
			{
				_boundsPerZone[zone].Encapsulate(roomBounds);
				return;
			}
			_boundsSet[zone] = true;
			_boundsPerZone[zone] = roomBounds;
		}
	}

	private bool CheckWhitelisted(RoomIdentifier room)
	{
		if (!_excludedRooms.Contains(room.Name))
		{
			return _whitelistedZones.Contains(room.Zone);
		}
		return false;
	}

	private Bounds GetRoomBounds(RoomIdentifier room)
	{
		return new Bounds(room.transform.position, _boundsSize);
	}
}
