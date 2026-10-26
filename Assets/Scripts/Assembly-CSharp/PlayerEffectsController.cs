using System;
using System.Collections.Generic;
using System.Linq;
using CustomPlayerEffects;
using InventorySystem.Items;
using Mirror;
using Mirror.RemoteCalls;
using NorthwoodLib.Pools;
using PlayerRoles;
using PlayerRoles.Spectating;
using UnityEngine;
using UnityEngine.Audio;
using Utils.NonAllocLINQ;

public class PlayerEffectsController : NetworkBehaviour
{
	public AudioMixer mixer;

	public GameObject effectsGameObject;

	private readonly Dictionary<Type, StatusEffectBase> _effectsByType = new Dictionary<Type, StatusEffectBase>();

	private readonly SyncList<byte> _syncEffectsIntensity = new SyncList<byte>();

	private bool _wasSpectated;

	private ReferenceHub _hub;

	public StatusEffectBase[] AllEffects { get; private set; }

	public IEnumerable<StatusEffectBase> EnabledEffects => AllEffects.Where((StatusEffectBase effect) => effect.IsEnabled);

	public int EffectsLength { get; private set; }

	public bool TryGetEffect(string effectName, out StatusEffectBase playerEffect)
	{
		StatusEffectBase[] allEffects = AllEffects;
		foreach (StatusEffectBase statusEffectBase in allEffects)
		{
			if (statusEffectBase.name.StartsWith(effectName, StringComparison.InvariantCultureIgnoreCase))
			{
				playerEffect = statusEffectBase;
				return true;
			}
		}
		playerEffect = null;
		return false;
	}

	public bool TryGetEffect<T>(out T playerEffect) where T : StatusEffectBase
	{
		if (_effectsByType.TryGetValue(typeof(T), out var value) && value is T val)
		{
			playerEffect = val;
			return true;
		}
		playerEffect = null;
		return false;
	}

	[Server]
	public void UseMedicalItem(ItemBase item)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void PlayerEffectsController::UseMedicalItem(InventorySystem.Items.ItemBase)' called when server was not active");
			return;
		}
		StatusEffectBase[] allEffects = AllEffects;
		foreach (StatusEffectBase statusEffectBase in allEffects)
		{
			if (statusEffectBase.IsEnabled && statusEffectBase is IHealableEffect healableEffect && healableEffect.IsHealable(item.ItemTypeId))
			{
				if (statusEffectBase is ICustomHealableEffect customHealableEffect)
				{
					customHealableEffect.OnHeal(item.ItemTypeId);
				}
				else
				{
					statusEffectBase.IsEnabled = false;
				}
			}
		}
	}

	[Server]
	public StatusEffectBase ChangeState(string effectName, byte intensity, float duration = 0f, bool addDuration = false)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'CustomPlayerEffects.StatusEffectBase PlayerEffectsController::ChangeState(System.String,System.Byte,System.Single,System.Boolean)' called when server was not active");
			return null;
		}
		if (TryGetEffect(effectName, out var playerEffect))
		{
			playerEffect.ServerSetState(intensity, duration, addDuration);
		}
		return playerEffect;
	}

	[Server]
	public T ChangeState<T>(byte intensity, float duration = 0f, bool addDuration = false) where T : StatusEffectBase
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'T PlayerEffectsController::ChangeState(System.Byte,System.Single,System.Boolean)' called when server was not active");
			return null;
		}
		if (TryGetEffect<T>(out var playerEffect))
		{
			playerEffect.ServerSetState(intensity, duration, addDuration);
		}
		return playerEffect;
	}

	[Server]
	public T EnableEffect<T>(float duration = 0f, bool addDuration = false) where T : StatusEffectBase
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'T PlayerEffectsController::EnableEffect(System.Single,System.Boolean)' called when server was not active");
			return null;
		}
		return ChangeState<T>(1, duration, addDuration);
	}

	[Server]
	public T DisableEffect<T>() where T : StatusEffectBase
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'T PlayerEffectsController::DisableEffect()' called when server was not active");
			return null;
		}
		return ChangeState<T>(0);
	}

	public void DisableAllEffects()
	{
		StatusEffectBase[] allEffects = AllEffects;
		for (int i = 0; i < allEffects.Length; i++)
		{
			allEffects[i].ServerDisable();
		}
	}

	public T GetEffect<T>() where T : StatusEffectBase
	{
		if (!TryGetEffect<T>(out var playerEffect))
		{
			return null;
		}
		return playerEffect;
	}

	[Server]
	public void ServerSyncEffect(StatusEffectBase effect)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void PlayerEffectsController::ServerSyncEffect(CustomPlayerEffects.StatusEffectBase)' called when server was not active");
			return;
		}
		for (int i = 0; i < EffectsLength; i++)
		{
			StatusEffectBase statusEffectBase = AllEffects[i];
			if (statusEffectBase == effect)
			{
				_syncEffectsIntensity[i] = statusEffectBase.Intensity;
				break;
			}
		}
	}

	public void ServerSendPulse<T>() where T : IPulseEffect
	{
		for (int i = 0; i < EffectsLength; i++)
		{
			if (AllEffects[i] is T)
			{
				byte index = (byte)Mathf.Min(i, 255);
				TargetRpcReceivePulse(_hub.connectionToClient, index);
				SpectatorNetworking.ForeachSpectatorOf(_hub, (ReferenceHub x) =>
				{
					TargetRpcReceivePulse(x.connectionToClient, index);
				});
				break;
			}
		}
	}

	[TargetRpc]
	private void TargetRpcReceivePulse(NetworkConnection _, byte effectIndex)
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		NetworkWriterExtensions.WriteByte(writer, effectIndex);
		SendTargetRPCInternal(_, "System.Void PlayerEffectsController::TargetRpcReceivePulse(Mirror.NetworkConnection,System.Byte)", 483637978, writer, 0);
		NetworkWriterPool.Return(writer);
	}

	private void Awake()
	{
		_hub = ReferenceHub.GetHub(base.gameObject);
		List<StatusEffectBase> list = ListPool<StatusEffectBase>.Shared.Rent();
		StatusEffectBase[] componentsInChildren = effectsGameObject.GetComponentsInChildren<StatusEffectBase>();
		foreach (StatusEffectBase statusEffectBase in componentsInChildren)
		{
			if (statusEffectBase is IHolidayEffect { IsAvailable: false })
			{
				statusEffectBase.gameObject.SetActive(value: false);
			}
			else
			{
				list.Add(statusEffectBase);
			}
		}
		AllEffects = list.ToArray();
		EffectsLength = AllEffects.Length;
		ListPool<StatusEffectBase>.Shared.Return(list);
		componentsInChildren = AllEffects;
		foreach (StatusEffectBase statusEffectBase2 in componentsInChildren)
		{
			_effectsByType.Add(statusEffectBase2.GetType(), statusEffectBase2);
			_syncEffectsIntensity.Add(0);
		}
	}

	private void Update()
	{
		if (NetworkServer.active)
		{
			return;
		}
		int num = Mathf.Min(EffectsLength, _syncEffectsIntensity.Count);
		for (int i = 0; i < num; i++)
		{
			AllEffects[i].ForceIntensity(_syncEffectsIntensity[i]);
		}
	}

	private void Start()
	{
		effectsGameObject.SetActive(value: true);
	}

	private void OnEnable()
	{
		PlayerRoleManager.OnRoleChanged += OnRoleChanged;
	}

	private void OnDisable()
	{
		PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
	}

	private void OnRoleChanged(ReferenceHub targetHub, PlayerRoleBase oldRole, PlayerRoleBase newRole)
	{
		if (targetHub != _hub)
		{
			return;
		}
		bool flag = oldRole.Team != Team.Dead && newRole.Team == Team.Dead;
		StatusEffectBase[] allEffects = AllEffects;
		foreach (StatusEffectBase statusEffectBase in allEffects)
		{
			if (flag)
			{
				statusEffectBase.OnDeath(oldRole);
			}
			else
			{
				statusEffectBase.OnRoleChanged(oldRole, newRole);
			}
		}
	}

	[RuntimeInitializeOnLoadMethod]
	private static void Init()
	{
		SpectatorTargetTracker.OnTargetChanged += () =>
		{
			if (ReferenceHub.AllHubs.TryGetFirst((ReferenceHub x) => x.playerEffectsController._wasSpectated, out var first))
			{
				StatusEffectBase[] allEffects = first.playerEffectsController.AllEffects;
				for (int num = 0; num < allEffects.Length; num++)
				{
					allEffects[num].OnStopSpectating();
				}
				first.playerEffectsController._wasSpectated = false;
			}
			if (SpectatorTargetTracker.TryGetTrackedPlayer(out var hub))
			{
				PlayerEffectsController playerEffectsController = hub.playerEffectsController;
				StatusEffectBase[] allEffects = playerEffectsController.AllEffects;
				for (int num = 0; num < allEffects.Length; num++)
				{
					allEffects[num].OnBeginSpectating();
				}
				playerEffectsController._wasSpectated = true;
			}
		};
	}

	public PlayerEffectsController()
	{
		InitSyncObject(_syncEffectsIntensity);
	}

	public override bool Weaved()
	{
		return true;
	}

	protected void UserCode_TargetRpcReceivePulse__NetworkConnection__Byte(NetworkConnection _, byte effectIndex)
	{
		int num = Mathf.Min(effectIndex, EffectsLength - 1);
		if (AllEffects[num] is IPulseEffect pulseEffect)
		{
			pulseEffect.ExecutePulse();
		}
	}

	protected static void InvokeUserCode_TargetRpcReceivePulse__NetworkConnection__Byte(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("TargetRPC TargetRpcReceivePulse called on server.");
		}
		else
		{
			((PlayerEffectsController)obj).UserCode_TargetRpcReceivePulse__NetworkConnection__Byte(null, NetworkReaderExtensions.ReadByte(reader));
		}
	}

	static PlayerEffectsController()
	{
		RemoteProcedureCalls.RegisterRpc(typeof(PlayerEffectsController), "System.Void PlayerEffectsController::TargetRpcReceivePulse(Mirror.NetworkConnection,System.Byte)", InvokeUserCode_TargetRpcReceivePulse__NetworkConnection__Byte);
	}
}
