using System.Collections.Generic;
using System.Runtime.InteropServices;
using Interactables;
using Interactables.Verification;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.ThrowableProjectiles;
using Mirror;
using UnityEngine;

public class Snowpile : NetworkBehaviour, IServerInteractable, IInteractable
{
	private static readonly int FadeHash = Shader.PropertyToID("_Fade");

	private const float MinDiff = 0.03f;

	private Material _mat;

	private float _prevSize;

	private float _regenerationTimer;

	private int _initialUses;

	[SyncVar]
	private Vector3 _position;

	[SyncVar]
	private Quaternion _rotation;

	[SyncVar]
	[SerializeField]
	private int _remainingUses;

	[SerializeField]
	private Transform _scaler;

	[SerializeField]
	private AnimationCurve _scaleOverUses;

	[SerializeField]
	private AnimationCurve _fadeOverUses;

	[SerializeField]
	private float _scaleAdjustSpeed;

	[SerializeField]
	private bool _regenerate;

	[SerializeField]
	private float _regenerationDuration;

	[SerializeField]
	private Renderer[] _renderers;

	public IVerificationRule VerificationRule { get; private set; } = new StandardDistanceVerification(8f);

	public Vector3 Network_position
	{
		get
		{
			return _position;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _position, 1uL, null);
		}
	}

	public Quaternion Network_rotation
	{
		get
		{
			return _rotation;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _rotation, 2uL, null);
		}
	}

	public int Network_remainingUses
	{
		get
		{
			return _remainingUses;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _remainingUses, 4uL, null);
		}
	}

	private void Awake()
	{
		_mat = new Material(_renderers[0].sharedMaterial);
		Renderer[] renderers = _renderers;
		for (int i = 0; i < renderers.Length; i++)
		{
			renderers[i].sharedMaterial = _mat;
		}
		_prevSize = 1f;
		_initialUses = _remainingUses;
	}

	private void Update()
	{
		if (NetworkServer.active)
		{
			ServerUpdate();
		}
		else
		{
			base.transform.SetPositionAndRotation(_position, _rotation);
		}
		float num = Mathf.Lerp(_prevSize, _remainingUses, Time.deltaTime * _scaleAdjustSpeed);
		if (!(Mathf.Abs(num - (float)_remainingUses) <= 0.03f))
		{
			_prevSize = num;
			float num2 = _fadeOverUses.Evaluate(num);
			_mat.SetFloat(FadeHash, num2);
			_scaler.gameObject.SetActive(num2 > 0f);
			_scaler.localScale = new Vector3(1f, _scaleOverUses.Evaluate(num), 1f);
		}
	}

	private void ServerUpdate()
	{
		Network_position = base.transform.position;
		Network_rotation = base.transform.rotation;
		if (_regenerate && _remainingUses < _initialUses)
		{
			_regenerationTimer += Time.deltaTime;
			if (!(_regenerationTimer < _regenerationDuration))
			{
				Network_remainingUses = _remainingUses + 1;
				_regenerationTimer = 0f;
			}
		}
	}

	public void ServerInteract(ReferenceHub ply, byte colliderId)
	{
		if (ply == null || _remainingUses <= 0 || !(ply.roleManager.CurrentRole is IInventoryRole))
		{
			return;
		}
		foreach (KeyValuePair<ushort, ItemBase> item in ply.inventory.UserInventory.Items)
		{
			if (item.Value is SnowballItem)
			{
				return;
			}
		}
		if (!(ply.inventory.ServerAddItem(ItemType.Snowball, ItemAddReason.PickedUp, 0) == null))
		{
			Network_remainingUses = _remainingUses - 1;
		}
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
			writer.WriteVector3(_position);
			writer.WriteQuaternion(_rotation);
			writer.WriteInt(_remainingUses);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteVector3(_position);
		}
		if ((base.syncVarDirtyBits & 2L) != 0L)
		{
			writer.WriteQuaternion(_rotation);
		}
		if ((base.syncVarDirtyBits & 4L) != 0L)
		{
			writer.WriteInt(_remainingUses);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref _position, null, reader.ReadVector3());
			GeneratedSyncVarDeserialize(ref _rotation, null, reader.ReadQuaternion());
			GeneratedSyncVarDeserialize(ref _remainingUses, null, reader.ReadInt());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _position, null, reader.ReadVector3());
		}
		if ((num & 2L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _rotation, null, reader.ReadQuaternion());
		}
		if ((num & 4L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _remainingUses, null, reader.ReadInt());
		}
	}
}
