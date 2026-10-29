using System;
using System.Collections.Generic;
using CustomRendering;
using MapGeneration;
using MapGeneration.Holidays;
using PlayerRoles.Spectating;
using UnityEngine;

// Restored from the client build (IL2CPP): switches to the surface fog while the local (or spectated) player is on the surface.
public class Outside : MonoBehaviour
{
	private static readonly Dictionary<HolidayType, FogType> HolidayDefaultFog = new Dictionary<HolidayType, FogType>
	{
		[HolidayType.None] = FogType.Outside,
		[HolidayType.Christmas] = FogType.ChristmasOutside,
		[HolidayType.Halloween] = FogType.HalloweenOutside
	};

	private FogSetting _outsideFog;

	public static Outside Singleton { get; private set; }

	public static event Action<bool> OnSetOutside;

	public static FogType OutsideFog
	{
		get
		{
			if (!HolidayDefaultFog.TryGetValue(GameCore.Version.ActiveHoliday, out var value))
			{
				return FogType.Outside;
			}
			return value;
		}
	}

	public bool IsFogEnabled => _outsideFog.IsEnabled;

	public void RefreshCameras()
	{
		OnSetOutside?.Invoke(_outsideFog.IsEnabled);
	}

	private void Awake()
	{
		if (Singleton != null)
		{
			UnityEngine.Object.Destroy(Singleton);
		}
		Singleton = this;
	}

	private void Start()
	{
		_outsideFog = FogController.Singleton.GetFogSetting(OutsideFog);
	}

	private void Update()
	{
		if (!ReferenceHub.TryGetLocalHub(out var hub))
		{
			return;
		}
		if (SpectatorTargetTracker.TryGetTrackedPlayer(out var tracked))
		{
			hub = tracked;
		}
		bool isOutside = hub.TryGetCurrentRoom(out var room) && room.Zone == FacilityZone.Surface;
		if (isOutside != _outsideFog.IsEnabled)
		{
			EnableOutsideFog(isOutside);
		}
	}

	private void EnableOutsideFog(bool newState)
	{
		if (newState)
		{
			FogController.EnableFogType(OutsideFog);
		}
		else
		{
			FogController.DisableFogType(OutsideFog);
		}
		OnSetOutside?.Invoke(_outsideFog.IsEnabled);
	}
}
