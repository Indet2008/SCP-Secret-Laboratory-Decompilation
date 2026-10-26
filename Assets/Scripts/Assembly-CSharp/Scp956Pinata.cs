using System.Collections.Generic;
using System.Runtime.InteropServices;
using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using InventorySystem.Items;
using MapGeneration;
using Mirror;
using Mirror.RemoteCalls;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using RelativePositioning;
using UnityEngine;
using Utils.NonAllocLINQ;

public class Scp956Pinata : NetworkBehaviour
{
	[SyncVar]
	private bool _spawned;

	[SyncVar]
	private Vector3 _syncPos;

	[SyncVar]
	private float _syncRot;

	[SyncVar]
	private bool _flying;

	[SyncVar]
	private byte _carpincho;

	[SerializeField]
	private AnimationCurve _attackCurve;

	[SerializeField]
	private AudioSource _attackSound;

	[SerializeField]
	private float _positionLerp;

	[SerializeField]
	private float _rotationLerp;

	[SerializeField]
	private Material _appearMat;

	[SerializeField]
	private float _appearSpeed;

	[SerializeField]
	private float _heightTolerance;

	[SerializeField]
	private GameObject _visuals;

	[SerializeField]
	private GameObject _capybara;

	[SerializeField]
	private Transform _attackMover;

	[SerializeField]
	private float _changePositionCooldown;

	[SerializeField]
	private float _huntingTime;

	[SerializeField]
	private float _pinataRadius;

	[SerializeField]
	private float _doorOffset;

	[SerializeField]
	private float _raycastRange;

	[SerializeField]
	private float _raycastHeight;

	[SerializeField]
	private float _minDistance;

	[SerializeField]
	private float _floorHeight;

	[SerializeField]
	private float _targettingThickness;

	[SerializeField]
	private float _targettingRange;

	[SerializeField]
	private float _flyingSinIntensity;

	[SerializeField]
	private float _flyingSinSpeed;

	[SerializeField]
	private FacilityZone[] _spawnableZones;

	private float _fade;

	private float _respawnTimer;

	private float _sequenceTimer;

	private float _attackTimer;

	private float _initialRot;

	private Vector3 _spawnPos;

	private Vector3 _initialPos;

	private Transform _tr;

	private Scp956Target _foundTarget;

	private bool _attackTriggered;

	private const float SqrCutoffPoint = 9f;

	public static readonly HashSet<ReferenceHub> ActiveTargets;

	private static readonly Dictionary<FacilityZone, int> ZonesByIntensity;

	private static readonly List<DoorVariant> CompatibleDoors;

	private static bool _hasBeenGiftSpawned;

	private static Scp956Pinata _instance;

	public static Vector3 LastPosition;

	public static bool IsSpawned
	{
		get
		{
			return _instance._spawned;
		}
		set
		{
			_instance.Network_spawned = value;
		}
	}

	private static float RandomSign => (Random.value > 0.5f) ? 1 : (-1);

	public bool Network_spawned
	{
		get
		{
			return _spawned;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _spawned, 1uL, null);
		}
	}

	public Vector3 Network_syncPos
	{
		get
		{
			return _syncPos;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _syncPos, 2uL, null);
		}
	}

	public float Network_syncRot
	{
		get
		{
			return _syncRot;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _syncRot, 4uL, null);
		}
	}

	public bool Network_flying
	{
		get
		{
			return _flying;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _flying, 8uL, null);
		}
	}

	public byte Network_carpincho
	{
		get
		{
			return _carpincho;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _carpincho, 16uL, null);
		}
	}

	public static bool TryGetInstance(out Scp956Pinata instance)
	{
		instance = _instance;
		return instance != null;
	}

	[ClientRpc]
	private void RpcAttack()
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		SendRPCInternal("System.Void Scp956Pinata::RpcAttack()", 977535511, writer, 0, includeOwner: true);
		NetworkWriterPool.Return(writer);
	}

	private void Awake()
	{
		_tr = base.transform;
		_instance = this;
	}

	private void Update()
	{
		UpdateVisual();
		if (NetworkServer.active)
		{
			UpdateAi();
		}
		UpdatePos();
	}

	private void UpdateVisual()
	{
		_attackTimer += Time.deltaTime;
		_attackMover.localPosition = Vector3.forward * _attackCurve.Evaluate(_attackTimer);
		float num = Mathf.Clamp01(_fade + _appearSpeed * Time.deltaTime * (float)(_spawned ? 1 : (-1)));
		bool flag = _carpincho == 67;
		_capybara.SetActive(flag && num > 0f);
		_visuals.SetActive(!flag && num > 0f);
		if (num != _fade)
		{
			_fade = num;
			_appearMat.SetFloat(Scp559Cake.ShaderDissolveProperty, 1f - _fade);
			_tr.rotation = Quaternion.Euler(Vector3.up * _syncRot);
		}
	}

	private void UpdateAi()
	{
		_respawnTimer -= Time.deltaTime;
		if (!_spawned && !_hasBeenGiftSpawned)
		{
			if (!(_respawnTimer > 0f))
			{
				if (!TryGetSpawnPos(out var pos))
				{
					_respawnTimer = _changePositionCooldown;
					return;
				}
				Network_carpincho = (byte)Random.Range(0, 255);
				Network_syncPos = pos;
				_spawnPos = pos;
				Network_syncRot = Random.value * 360f;
				Network_spawned = true;
				Network_flying = false;
				_respawnTimer = _huntingTime;
			}
			return;
		}
		foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
		{
			Scp956Target.EffectReason effectReason = CheckSpawnCondition(allHub);
			if (effectReason == Scp956Target.EffectReason.None || !CheckPlayer(allHub))
			{
				if (ActiveTargets.Remove(allHub))
				{
					allHub.playerEffectsController.DisableEffect<Scp956Target>();
				}
			}
			else
			{
				ActiveTargets.Add(allHub);
				allHub.playerEffectsController.GetEffect<Scp956Target>().Intensity = (byte)effectReason;
				_respawnTimer = _huntingTime;
			}
		}
		if (_respawnTimer < 0f)
		{
			TryDespawn();
			return;
		}
		bool flag = _foundTarget == null;
		if (!flag && (CheckSpawnCondition(_foundTarget.Hub) == Scp956Target.EffectReason.None || !ActiveTargets.Contains(_foundTarget.Hub)))
		{
			_foundTarget = null;
			flag = true;
		}
		if (flag)
		{
			float num = float.MaxValue;
			bool flag2 = false;
			foreach (ReferenceHub activeTarget in ActiveTargets)
			{
				Scp956Target effect = activeTarget.playerEffectsController.GetEffect<Scp956Target>();
				if (effect.IsAffected)
				{
					float sqrMagnitude = (effect.Position - _tr.position).sqrMagnitude;
					if (!(sqrMagnitude > num))
					{
						_foundTarget = effect;
						num = sqrMagnitude;
						flag2 = true;
					}
				}
			}
			if (!flag2)
			{
				return;
			}
			_sequenceTimer = 0f;
			_initialRot = _syncRot;
			_initialPos = _syncPos;
			_attackTriggered = false;
		}
		_sequenceTimer += Time.deltaTime;
		Vector3 normalized = (_foundTarget.Position - _tr.position).normalized;
		float b = Vector3.Angle(normalized, Vector3.forward) * Mathf.Sign(Vector3.Dot(normalized, Vector3.right));
		Network_syncRot = Mathf.LerpAngle(_initialRot, b, (_sequenceTimer - 1f) / 4f);
		if (_sequenceTimer < 6f)
		{
			return;
		}
		Vector3 b2 = _foundTarget.Position - _tr.forward.NormalizeIgnoreY();
		if (Mathf.Abs(_spawnPos.y - _foundTarget.Position.y) < _heightTolerance)
		{
			b2.y = _spawnPos.y;
			Network_flying = false;
		}
		else
		{
			b2.y = _foundTarget.Position.y;
			Network_flying = true;
		}
		Network_syncPos = Vector3.Lerp(_initialPos, b2, (_sequenceTimer - 6f) / 7f);
		if (!(_sequenceTimer < 13.3f))
		{
			if (!_attackTriggered)
			{
				RpcAttack();
				_attackTriggered = true;
			}
			if (!(_sequenceTimer < 13.5f))
			{
				_foundTarget.Hub.playerStats.DealDamage(new Scp956DamageHandler(normalized));
				_foundTarget = null;
			}
		}
	}

	public void SpawnBehindTarget(ReferenceHub target)
	{
		ActiveTargets.Add(target);
		_foundTarget = target.playerEffectsController.EnableEffect<Scp956Target>();
		_foundTarget.Intensity = 254;
		_respawnTimer = _huntingTime;
		Transform transform = target.transform;
		Vector3 initialPos = (Network_syncPos = (_spawnPos = transform.position - transform.forward * 2f));
		_initialPos = initialPos;
		float initialRot = (Network_syncRot = Random.value * 360f);
		_initialRot = initialRot;
		_respawnTimer = _huntingTime;
		_attackTriggered = false;
		bool hasBeenGiftSpawned = (Network_spawned = true);
		_hasBeenGiftSpawned = hasBeenGiftSpawned;
	}

	private void TryDespawn()
	{
		Vector3 thisPos = _tr.position;
		if (!ReferenceHub.AllHubs.Any((ReferenceHub x) => x.roleManager.CurrentRole is IFpcRole fpcRole && CheckVisibility(thisPos, fpcRole.FpcModule.Position)))
		{
			Network_spawned = false;
			_respawnTimer = _changePositionCooldown;
		}
	}

	private bool CheckPlayer(ReferenceHub hub)
	{
		Vector3 position = _tr.position;
		Vector3 position2 = (hub.roleManager.CurrentRole as HumanRole).FpcModule.Position;
		float num = _targettingRange * _targettingRange;
		if ((position - position2).sqrMagnitude > num)
		{
			return false;
		}
		if (!CheckVisibility(position, position2))
		{
			return false;
		}
		if (!WaypointBase.TryGetWaypoint(new RelativePosition(position2).WaypointId, out var wp))
		{
			return true;
		}
		return !(wp is ElevatorWaypoint);
	}

	private bool TryGetSpawnPos(out Vector3 pos)
	{
		pos = default;
		ZonesByIntensity.Clear();
		foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
		{
			if (CheckSpawnCondition(allHub) == Scp956Target.EffectReason.Child && allHub.roleManager.CurrentRole is HumanRole && allHub.TryGetCurrentRoom(out var room) && _spawnableZones.Contains(room.Zone))
			{
				ZonesByIntensity.TryGetValue(room.Zone, out var value);
				ZonesByIntensity[room.Zone] = value + 1;
			}
		}
		if (ZonesByIntensity.Count == 0)
		{
			return false;
		}
		FacilityZone facilityZone = FacilityZone.None;
		int num = 0;
		foreach (KeyValuePair<FacilityZone, int> item in ZonesByIntensity)
		{
			if (item.Value >= num)
			{
				facilityZone = item.Key;
				num = item.Value;
			}
		}
		CompatibleDoors.Clear();
		foreach (DoorVariant allDoor in DoorVariant.AllDoors)
		{
			if (allDoor is BreakableDoor && allDoor.Rooms != null && allDoor.Rooms.Length != 0 && allDoor.Rooms[0].Zone == facilityZone)
			{
				CompatibleDoors.Add(allDoor);
			}
		}
		while (CompatibleDoors.Count > 0)
		{
			int index = Random.Range(0, CompatibleDoors.Count);
			Transform transform = CompatibleDoors[index].transform;
			CompatibleDoors.RemoveAt(index);
			pos = transform.position + _doorOffset * RandomSign * transform.forward + Vector3.up * _raycastHeight;
			if (Physics.SphereCast(pos, _pinataRadius, transform.right * RandomSign, out var hitInfo, _raycastRange, FpcStateProcessor.Mask) && !(hitInfo.distance < _minDistance))
			{
				Vector3 vector = hitInfo.point + hitInfo.normal * _pinataRadius;
				pos = new Vector3(vector.x, transform.position.y + _floorHeight, vector.z);
				Vector3 checkPos = pos;
				if (!ReferenceHub.AllHubs.Any((ReferenceHub x) => x.roleManager.CurrentRole is IFpcRole fpcRole && CheckVisibility(checkPos, fpcRole.FpcModule.Position)))
				{
					return true;
				}
			}
		}
		return false;
	}

	private bool CheckVisibility(Vector3 checkPos, Vector3 humanPos)
	{
		return !Physics.CheckCapsule(checkPos, humanPos, _targettingThickness, FpcStateProcessor.Mask);
	}

	private Scp956Target.EffectReason CheckSpawnCondition(ReferenceHub hub)
	{
		if (!(hub.roleManager.CurrentRole is HumanRole))
		{
			return Scp956Target.EffectReason.None;
		}
		if (hub.playerEffectsController.GetEffect<Scp559Effect>().IsEnabled)
		{
			return Scp956Target.EffectReason.Child;
		}
		if (!hub.inventory.UserInventory.Items.Any((KeyValuePair<ushort, ItemBase> x) => x.Value.ItemTypeId == ItemType.SCP330))
		{
			return Scp956Target.EffectReason.None;
		}
		return Scp956Target.EffectReason.HasCandy;
	}

	private void UpdatePos()
	{
		Vector3 position = _tr.position;
		Vector3 syncPos = _syncPos;
		if (_flying)
		{
			syncPos.y += Mathf.Sin(Time.timeSinceLevelLoad * _flyingSinSpeed) * _flyingSinIntensity;
		}
		if ((position - syncPos).sqrMagnitude > 9f)
		{
			_tr.position = _syncPos;
		}
		_tr.SetPositionAndRotation(Vector3.Lerp(position, syncPos, Time.deltaTime * _positionLerp), Quaternion.Lerp(_tr.rotation, Quaternion.Euler(Vector3.up * _syncRot), Time.deltaTime * _rotationLerp));
		LastPosition = position;
	}

	[RuntimeInitializeOnLoadMethod]
	private static void Init()
	{
		ReferenceHub.OnPlayerRemoved += (ReferenceHub hub) =>
		{
			ActiveTargets.Remove(hub);
		};
	}

	static Scp956Pinata()
	{
		ActiveTargets = new HashSet<ReferenceHub>();
		ZonesByIntensity = new Dictionary<FacilityZone, int>();
		CompatibleDoors = new List<DoorVariant>();
		_hasBeenGiftSpawned = false;
		RemoteProcedureCalls.RegisterRpc(typeof(Scp956Pinata), "System.Void Scp956Pinata::RpcAttack()", InvokeUserCode_RpcAttack);
	}

	public override bool Weaved()
	{
		return true;
	}

	protected void UserCode_RpcAttack()
	{
		_attackTimer = 0f;
		_attackSound.Play();
	}

	protected static void InvokeUserCode_RpcAttack(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("RPC RpcAttack called on server.");
		}
		else
		{
			((Scp956Pinata)obj).UserCode_RpcAttack();
		}
	}

	protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
	{
		base.SerializeSyncVars(writer, forceAll);
		if (forceAll)
		{
			writer.WriteBool(_spawned);
			writer.WriteVector3(_syncPos);
			writer.WriteFloat(_syncRot);
			writer.WriteBool(_flying);
			NetworkWriterExtensions.WriteByte(writer, _carpincho);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteBool(_spawned);
		}
		if ((base.syncVarDirtyBits & 2L) != 0L)
		{
			writer.WriteVector3(_syncPos);
		}
		if ((base.syncVarDirtyBits & 4L) != 0L)
		{
			writer.WriteFloat(_syncRot);
		}
		if ((base.syncVarDirtyBits & 8L) != 0L)
		{
			writer.WriteBool(_flying);
		}
		if ((base.syncVarDirtyBits & 0x10L) != 0L)
		{
			NetworkWriterExtensions.WriteByte(writer, _carpincho);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref _spawned, null, reader.ReadBool());
			GeneratedSyncVarDeserialize(ref _syncPos, null, reader.ReadVector3());
			GeneratedSyncVarDeserialize(ref _syncRot, null, reader.ReadFloat());
			GeneratedSyncVarDeserialize(ref _flying, null, reader.ReadBool());
			GeneratedSyncVarDeserialize(ref _carpincho, null, NetworkReaderExtensions.ReadByte(reader));
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _spawned, null, reader.ReadBool());
		}
		if ((num & 2L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _syncPos, null, reader.ReadVector3());
		}
		if ((num & 4L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _syncRot, null, reader.ReadFloat());
		}
		if ((num & 8L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _flying, null, reader.ReadBool());
		}
		if ((num & 0x10L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _carpincho, null, NetworkReaderExtensions.ReadByte(reader));
		}
	}
}
