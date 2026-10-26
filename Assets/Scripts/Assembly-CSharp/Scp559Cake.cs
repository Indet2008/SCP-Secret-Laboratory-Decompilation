using System.Collections.Generic;
using System.Runtime.InteropServices;
using AudioPooling;
using GameCore;
using Interactables;
using Interactables.Verification;
using MapGeneration;
using Mirror;
using PlayerRoles;
using UnityEngine;

public class Scp559Cake : NetworkBehaviour, IServerInteractable, IInteractable
{
	private const float SpawnChance = 33f;

	public static readonly int ShaderDissolveProperty = Shader.PropertyToID("_Dissolve");

	private static readonly CachedLayerMask CheckerMask = new CachedLayerMask("Pickup", "Hitbox");

	private static readonly List<Scp559Spawnpoint> PossibleSpawnpoints = new List<Scp559Spawnpoint>();

	private static readonly Dictionary<RoomIdentifier, int> PopulatedRooms = new Dictionary<RoomIdentifier, int>();

	[SerializeField]
	private GameObject _visuals;

	[SerializeField]
	private GameObject _pedestal;

	[SerializeField]
	private Material _dissolveMat;

	[SerializeField]
	private GameObject[] _slices;

	[SerializeField]
	private float _dissolveSpeed;

	[SerializeField]
	private AudioClip _useSound;

	[SerializeField]
	private AudioClip _appearSound;

	[SerializeField]
	private AudioClip _disappearClip;

	[SerializeField]
	private byte _maxSlices;

	[SyncVar]
	private byte _remainingSlices;

	[SyncVar]
	private bool _isSpawned;

	[SyncVar]
	private bool _hasPedestal;

	[SerializeField]
	private float _spawnedDuration;

	[SerializeField]
	private float _respawnTime;

	[SerializeField]
	private float _cakeRadius;

	[SyncVar(hook = "SetPosition")]
	private Vector3 _position;

	private float _fade;

	private float _remainingTime;

	private int _prevSlices = -1;

	public IVerificationRule VerificationRule => StandardDistanceVerification.Default;

	public bool CanBeUsed => _remainingSlices > 0;

	public byte Network_remainingSlices
	{
		get
		{
			return _remainingSlices;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _remainingSlices, 1uL, null);
		}
	}

	public bool Network_isSpawned
	{
		get
		{
			return _isSpawned;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _isSpawned, 2uL, null);
		}
	}

	public bool Network_hasPedestal
	{
		get
		{
			return _hasPedestal;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _hasPedestal, 4uL, null);
		}
	}

	public Vector3 Network_position
	{
		get
		{
			return _position;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _position, 8uL, SetPosition);
		}
	}

	public void ServerInteract(ReferenceHub ply, byte colliderId)
	{
		if (_isSpawned && ply.IsHuman() && _remainingSlices != 0)
		{
			Scp559Effect effect = ply.playerEffectsController.GetEffect<Scp559Effect>();
			if (!effect.IsEnabled)
			{
				Network_remainingSlices = (byte)(_remainingSlices - 1);
				effect.IsEnabled = true;
			}
		}
	}

	private void Update()
	{
		if (NetworkServer.active)
		{
			UpdateServer();
		}
		UpdateVisual();
	}

	private void Start()
	{
		SetPosition(_position, _position);
	}

	private void SetPosition(Vector3 prev, Vector3 cur)
	{
		base.transform.position = cur;
	}

	private void UpdateServer()
	{
		_remainingTime -= Time.deltaTime;
		if (!(_remainingTime > 0f))
		{
			Vector3 pos;
			bool pedestal;
			if (_isSpawned)
			{
				Network_isSpawned = false;
				_remainingTime = _respawnTime;
			}
			else if (RoundStart.RoundStarted && !(RoundStart.RoundLength.TotalSeconds < (double)_respawnTime) && TryGetSpawnPoint(out pos, out pedestal))
			{
				Network_position = pos;
				Network_isSpawned = true;
				Network_hasPedestal = pedestal;
				Network_remainingSlices = _maxSlices;
				_remainingTime = _spawnedDuration;
			}
		}
	}

	private void UpdateVisual()
	{
		_pedestal.SetActive(_hasPedestal);
		float num = Mathf.Clamp01(_fade + _dissolveSpeed * Time.deltaTime * (float)(_isSpawned ? 1 : (-1)));
		if (num != _fade)
		{
			if (_fade <= 0f)
			{
				AudioSourcePoolManager.PlayOnTransform(_appearSound, base.transform, 25f);
			}
			if (_fade >= 1f)
			{
				AudioSourcePoolManager.PlayOnTransform(_disappearClip, base.transform, 15f);
			}
			_fade = num;
			_dissolveMat.SetFloat(ShaderDissolveProperty, 1f - _fade);
			_visuals.SetActive(_fade > 0f);
			_prevSlices = -1;
			_slices.ForEach((GameObject x) =>
			{
				x.SetActive(value: false);
			});
		}
		else if (_prevSlices != _remainingSlices)
		{
			for (int num2 = 0; num2 < _slices.Length; num2++)
			{
				_slices[num2].SetActive(num2 < _remainingSlices);
			}
			if (_prevSlices > _remainingSlices)
			{
				AudioSourcePoolManager.PlayOnTransform(_useSound, base.transform, 9f);
			}
			_prevSlices = _remainingSlices;
		}
	}

	private bool TryGetSpawnPoint(out Vector3 pos, out bool pedestal)
	{
		PossibleSpawnpoints.Clear();
		PopulatedRooms.Clear();
		int num = 0;
		Dictionary<RoomIdentifier, Scp559Spawnpoint> instancesPerRoom = Scp559Spawnpoint.InstancesPerRoom;
		foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
		{
			if (allHub.roleManager.CurrentRole is HumanRole && allHub.TryGetCurrentRoom(out var room) && instancesPerRoom.ContainsKey(room))
			{
				PopulatedRooms.TryGetValue(room, out var value);
				if (!allHub.playerEffectsController.GetEffect<Scp559Effect>().IsEnabled)
				{
					value++;
				}
				PopulatedRooms[room] = value;
				num = Mathf.Max(value, num);
			}
		}
		foreach (KeyValuePair<RoomIdentifier, int> populatedRoom in PopulatedRooms)
		{
			if (populatedRoom.Value >= num)
			{
				Scp559Spawnpoint scp559Spawnpoint = instancesPerRoom[populatedRoom.Key];
				if (!Physics.CheckSphere(scp559Spawnpoint.transform.position, _cakeRadius, CheckerMask))
				{
					PossibleSpawnpoints.Add(scp559Spawnpoint);
				}
			}
		}
		if (PossibleSpawnpoints.Count == 0)
		{
			pos = Vector3.zero;
			pedestal = false;
			return false;
		}
		Scp559Spawnpoint scp559Spawnpoint2 = PossibleSpawnpoints.RandomItem();
		pos = scp559Spawnpoint2.transform.position;
		if (scp559Spawnpoint2.HidePedestal)
		{
			pedestal = false;
			pos += Vector3.down * 1.042f;
		}
		else
		{
			pedestal = true;
		}
		return true;
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
			NetworkWriterExtensions.WriteByte(writer, _remainingSlices);
			writer.WriteBool(_isSpawned);
			writer.WriteBool(_hasPedestal);
			writer.WriteVector3(_position);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			NetworkWriterExtensions.WriteByte(writer, _remainingSlices);
		}
		if ((base.syncVarDirtyBits & 2L) != 0L)
		{
			writer.WriteBool(_isSpawned);
		}
		if ((base.syncVarDirtyBits & 4L) != 0L)
		{
			writer.WriteBool(_hasPedestal);
		}
		if ((base.syncVarDirtyBits & 8L) != 0L)
		{
			writer.WriteVector3(_position);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref _remainingSlices, null, NetworkReaderExtensions.ReadByte(reader));
			GeneratedSyncVarDeserialize(ref _isSpawned, null, reader.ReadBool());
			GeneratedSyncVarDeserialize(ref _hasPedestal, null, reader.ReadBool());
			GeneratedSyncVarDeserialize(ref _position, SetPosition, reader.ReadVector3());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _remainingSlices, null, NetworkReaderExtensions.ReadByte(reader));
		}
		if ((num & 2L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _isSpawned, null, reader.ReadBool());
		}
		if ((num & 4L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _hasPedestal, null, reader.ReadBool());
		}
		if ((num & 8L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _position, SetPosition, reader.ReadVector3());
		}
	}
}
