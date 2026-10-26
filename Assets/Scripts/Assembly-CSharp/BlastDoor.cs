using System.Collections.Generic;
using System.Runtime.InteropServices;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using Mirror;
using UnityEngine;

[RequireComponent(typeof(NetworkIdentity))]
public class BlastDoor : NetworkBehaviour
{
	public static readonly HashSet<BlastDoor> Instances = new HashSet<BlastDoor>();

	private static readonly int _isOpenId = Animator.StringToHash("IsOpen");

	private Animator _animator;

	[SyncVar(hook = "SetDoorState")]
	private bool _isOpen = true;

	public bool IsOpen => _isOpen;

	public bool Network_isOpen
	{
		get
		{
			return _isOpen;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _isOpen, 1uL, SetDoorState);
		}
	}

	public override void OnStartClient()
	{
		base.OnStartClient();
		SetDoorState(_: true, _isOpen);
	}

	private void Start()
	{
		Instances.Add(this);
	}

	private void OnDestroy()
	{
		Instances.Remove(this);
	}

	private void SetDoorState(bool _, bool newState)
	{
		BlastDoorChangingEventArgs e = new BlastDoorChangingEventArgs(this, newState);
		ServerEvents.OnBlastDoorChanging(e);
		if (e.IsAllowed)
		{
			Network_isOpen = newState;
			if (_animator == null)
			{
				_animator = GetComponent<Animator>();
			}
			_animator.SetBool(_isOpenId, newState);
			ServerEvents.OnBlastDoorChanged(new BlastDoorChangedEventArgs(this, newState));
		}
	}

	[Server]
	public void ServerSetTargetState(bool isOpen)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void BlastDoor::ServerSetTargetState(System.Boolean)' called when server was not active");
		}
		else
		{
			SetDoorState(_isOpen, isOpen);
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
			writer.WriteBool(_isOpen);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteBool(_isOpen);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref _isOpen, SetDoorState, reader.ReadBool());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _isOpen, SetDoorState, reader.ReadBool());
		}
	}
}
