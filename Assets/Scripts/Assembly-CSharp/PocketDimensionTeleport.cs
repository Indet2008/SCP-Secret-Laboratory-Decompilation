using System;
using System.Collections.Generic;
using CustomPlayerEffects;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.Scp106;
using PlayerStatsSystem;
using UnityEngine;

public class PocketDimensionTeleport : NetworkBehaviour
{
	public delegate void PlayerEscapePocketDimension(ReferenceHub hub);

	public enum PDTeleportType
	{
		Killer = 0,
		Exit = 1
	}

	public static readonly HashSet<PocketDimensionTeleport> AllInstances = new HashSet<PocketDimensionTeleport>();

	public const float DisabledDuration = 10f;

	public static bool DebugBool;

	public static bool RefreshExit;

	private const float MinAliveDuration = 1f;

	private static bool _anyModified;

	private PDTeleportType _type;

	public static event Action<PocketDimensionTeleport> OnAdded;

	public static event Action<PocketDimensionTeleport> OnRemoved;

	public static event Action OnInstancesUpdated;

	public static event PlayerEscapePocketDimension OnPlayerEscapePocketDimension;

	public void SetType(PDTeleportType t)
	{
		_type = t;
	}

	public PDTeleportType GetTeleportType()
	{
		return _type;
	}

	public static void TryExit(PocketDimensionTeleport instance, ReferenceHub hub)
	{
		if (!(hub.roleManager.CurrentRole is IFpcRole))
		{
			return;
		}
		PlayerLeavingPocketDimensionEventArgs e = new PlayerLeavingPocketDimensionEventArgs(hub, instance, isSuccessful: true);
		PlayerEvents.OnLeavingPocketDimension(e);
		if (e.IsAllowed)
		{
			if (!e.IsSuccessful)
			{
				Kill(instance, hub);
			}
			else
			{
				Exit(instance, hub);
			}
		}
	}

	public static void Exit(PocketDimensionTeleport instance, ReferenceHub hub)
	{
		if (hub.roleManager.CurrentRole is IFpcRole fpcRole)
		{
			fpcRole.FpcModule.ServerOverridePosition(Scp106PocketExitFinder.GetBestExitPosition(fpcRole));
			hub.playerEffectsController.EnableEffect<Disabled>(10f, addDuration: true);
			hub.playerEffectsController.EnableEffect<Traumatized>();
			hub.playerEffectsController.DisableEffect<PocketCorroding>();
			hub.playerEffectsController.DisableEffect<Corroding>();
			OnPlayerEscapePocketDimension?.Invoke(hub);
			PocketDimensionGenerator.RandomizeTeleports();
			PlayerEvents.OnLeftPocketDimension(new PlayerLeftPocketDimensionEventArgs(hub, instance, isSuccessful: true));
		}
	}

	public static void TryKill(PocketDimensionTeleport instance, ReferenceHub hub)
	{
		PlayerLeavingPocketDimensionEventArgs e = new PlayerLeavingPocketDimensionEventArgs(hub, instance, isSuccessful: false);
		PlayerEvents.OnLeavingPocketDimension(e);
		if (e.IsAllowed)
		{
			if (e.IsSuccessful)
			{
				Exit(instance, hub);
			}
			else
			{
				Kill(instance, hub);
			}
		}
	}

	public static void Kill(PocketDimensionTeleport instance, ReferenceHub hub)
	{
		hub.playerStats.DealDamage(new UniversalDamageHandler(-1f, DeathTranslations.PocketDecay));
		PlayerEvents.OnLeftPocketDimension(new PlayerLeftPocketDimensionEventArgs(hub, instance, isSuccessful: false));
	}

	private void Awake()
	{
		_anyModified = true;
		AllInstances.Add(this);
	}

	private void Start()
	{
		OnAdded?.Invoke(this);
	}

	private void OnDestroy()
	{
		_anyModified = true;
		AllInstances.Remove(this);
		OnRemoved?.Invoke(this);
	}

	private void Update()
	{
		if (_anyModified)
		{
			OnInstancesUpdated?.Invoke();
			_anyModified = false;
		}
	}

	[ServerCallback]
	private void OnTriggerEnter(Collider other)
	{
		if (!NetworkServer.active)
		{
			return;
		}
		NetworkIdentity component = other.GetComponent<NetworkIdentity>();
		if (!(component == null) && ReferenceHub.TryGetHubNetID(component.netId, out var hub) && !(hub.roleManager.CurrentRole.ActiveTime < 1f))
		{
			if ((_type == PDTeleportType.Killer || AlphaWarheadController.Detonated) && !DebugBool)
			{
				TryKill(this, hub);
			}
			else if (_type == PDTeleportType.Exit || DebugBool)
			{
				TryExit(this, hub);
			}
		}
	}

	public override bool Weaved()
	{
		return true;
	}
}
