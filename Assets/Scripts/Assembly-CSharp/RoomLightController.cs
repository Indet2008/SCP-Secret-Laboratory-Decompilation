using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using MapGeneration;
using Mirror;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using Utils.NonAllocLINQ;

public class RoomLightController : NetworkBehaviour
{
	public const float HeightRadius = 50f;

	private float _flickerDuration;

	private RoomIdentifier _cachedRoom;

	private bool _roomCacheSet;

	private const string IgnoreBlackoutsTag = "IgnoreBlackouts";

	private List<RoomLight> _cachedLights;

	private List<HDProbe> _cachedReflectionProbes;

	private bool _listCacheSet;

	[SyncVar(hook = "LightsEnabledHook")]
	public bool LightsEnabled;

	[SyncVar(hook = "OverrideColorHook")]
	public Color OverrideColor;

	public static readonly List<RoomLightController> Instances = new List<RoomLightController>();

	public RoomIdentifier Room
	{
		get
		{
			if (!_roomCacheSet)
			{
				if (!base.transform.TryGetComponentInParent<RoomIdentifier>(out _cachedRoom))
				{
					throw new NullReferenceException("Null room for Light Controller: " + base.transform.GetHierarchyPath());
				}
				_roomCacheSet = true;
			}
			return _cachedRoom;
		}
	}

	public bool NetworkLightsEnabled
	{
		get
		{
			return LightsEnabled;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref LightsEnabled, 1uL, LightsEnabledHook);
		}
	}

	public Color NetworkOverrideColor
	{
		get
		{
			return OverrideColor;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref OverrideColor, 2uL, OverrideColorHook);
		}
	}

	public static event Action<RoomLightController> OnAdded;

	public static event Action<RoomLightController> OnRemoved;

	public event Action<bool> OnLightsSet;

	public List<RoomLight> LightsInRoom
	{
		get
		{
			PrepareListCache();
			return _cachedLights;
		}
	}

	public List<HDProbe> ReflectionProbes
	{
		get
		{
			PrepareListCache();
			return _cachedReflectionProbes;
		}
	}

	private void Start()
	{
		if (NetworkServer.active)
		{
			NetworkLightsEnabled = true;
		}
		else
		{
			SetLights(LightsEnabled);
		}
		Instances.Add(this);
		OnAdded?.Invoke(this);
		Room.LightControllers.AddIfNotContains(this);
	}

	private void OnDestroy()
	{
		Instances.Remove(this);
		OnRemoved?.Invoke(this);
	}

	// Lights and baked reflection probes of the room within HeightRadius of this controller. Cached once the map has generated.
	private void PrepareListCache()
	{
		if (_listCacheSet)
		{
			return;
		}
		Transform parent = base.transform.parent;
		float y = base.transform.position.y;
		_cachedLights = new List<RoomLight>();
		_cachedReflectionProbes = new List<HDProbe>();
		RoomLight[] lights = parent.GetComponentsInChildren<RoomLight>(includeInactive: true);
		foreach (RoomLight roomLight in lights)
		{
			if (!(Mathf.Abs(roomLight.transform.position.y - y) > 50f))
			{
				_cachedLights.Add(roomLight);
			}
		}
		HDProbe[] probes = parent.GetComponentsInChildren<HDProbe>(includeInactive: true);
		foreach (HDProbe hDProbe in probes)
		{
			if (!(Mathf.Abs(hDProbe.transform.position.y - y) > 50f) && hDProbe.mode != ProbeSettings.Mode.Realtime && !hDProbe.gameObject.CompareTag("IgnoreBlackouts"))
			{
				_cachedReflectionProbes.Add(hDProbe);
			}
		}
		if (SeedSynchronizer.MapGenerated)
		{
			_listCacheSet = true;
		}
	}

	private void Update()
	{
		if (NetworkServer.active && !(_flickerDuration <= 0f))
		{
			_flickerDuration -= Time.deltaTime;
			if (!(_flickerDuration > 0f))
			{
				SetLights(state: true);
			}
		}
	}

	private void SetLights(bool state)
	{
		if (NetworkServer.active)
		{
			NetworkLightsEnabled = state;
		}
		SetProbeIntensity(state);
		foreach (RoomLight item in LightsInRoom)
		{
			if (!(item == null))
			{
				item.SetBlackout(!state);
			}
		}
		OnLightsSet?.Invoke(state);
	}

	private void SetProbeIntensity(bool state)
	{
		foreach (HDProbe reflectionProbe in ReflectionProbes)
		{
			if (!(reflectionProbe == null))
			{
				reflectionProbe.multiplier = (state ? 1 : 0);
			}
		}
	}

	private void LightsEnabledHook(bool oldValue, bool newValue)
	{
		ServerEvents.OnRoomLightChanged(new RoomLightChangedEventArgs(Room, newValue));
		SetLights(newValue);
	}

	private void OverrideColorHook(Color oldValue, Color newValue)
	{
		ServerEvents.OnRoomColorChanged(new RoomColorChangedEventArgs(Room, newValue));
		bool flag = newValue == Color.clear;
		foreach (RoomLight item in LightsInRoom)
		{
			if (!(item == null))
			{
				if (flag)
				{
					item.ResetOverrideColor();
				}
				else
				{
					item.SetOverrideColor(newValue);
				}
			}
		}
	}

	[Server]
	public void ServerFlickerLights(float dur)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void RoomLightController::ServerFlickerLights(System.Single)' called when server was not active");
		}
		else if (dur <= 0f)
		{
			_flickerDuration = 0f;
			SetLights(state: true);
		}
		else
		{
			_flickerDuration = dur;
			SetLights(state: false);
		}
	}

	public static bool IsInDarkenedRoom(Vector3 positionToCheck)
	{
		if (positionToCheck.TryGetRoom(out var room))
		{
			return IsInDarkenedRoom(room, positionToCheck);
		}
		return false;
	}

	public static bool IsInDarkenedRoom(RoomIdentifier rid, Vector3 positionToCheck)
	{
		foreach (RoomLightController lightController in rid.LightControllers)
		{
			float num = Mathf.Abs(lightController.transform.position.y - positionToCheck.y);
			if (!lightController.LightsEnabled && !(num > 50f))
			{
				return true;
			}
		}
		return false;
	}

	public override bool Weaved()
	{
		return true;
	}

	protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
	{
		base.SerializeSyncVars(writer, forceAll);
		if (forceAll)
		{
			writer.WriteBool(LightsEnabled);
			writer.WriteColor(OverrideColor);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteBool(LightsEnabled);
		}
		if ((base.syncVarDirtyBits & 2L) != 0L)
		{
			writer.WriteColor(OverrideColor);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref LightsEnabled, LightsEnabledHook, reader.ReadBool());
			GeneratedSyncVarDeserialize(ref OverrideColor, OverrideColorHook, reader.ReadColor());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref LightsEnabled, LightsEnabledHook, reader.ReadBool());
		}
		if ((num & 2L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref OverrideColor, OverrideColorHook, reader.ReadColor());
		}
	}
}
