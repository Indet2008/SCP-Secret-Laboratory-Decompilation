using System.Runtime.InteropServices;
using Interactables;
using Interactables.Interobjects.DoorUtils;
using Interactables.Verification;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using Mirror.RemoteCalls;
using UnityEngine;

public class AlphaWarheadNukesitePanel : NetworkBehaviour, IServerInteractable, IInteractable
{
	private enum DiodeType
	{
		InProgress = 0,
		BlastDoor = 1,
		OutsideDoor = 2
	}

	private enum PanelColliderId
	{
		Cancel = 1,
		Lever = 2
	}

	public Transform lever;

	[SerializeField]
	private MeshRenderer _ledRenderer;

	[SerializeField]
	private Material _onMat;

	[SerializeField]
	private Material _offMat;

	[SerializeField]
	private Quaternion _enabledLeverRotation;

	[SerializeField]
	private Quaternion _disabledLeverRotation;

	[SyncVar]
	public new bool enabled;

	private float _leverStatus;

	private Material[] _matSet;

	private bool[] _prevMats;

	private bool _anyModified;

	private const string OutsideDoorName = "SURFACE_NUKE";

	public static AlphaWarheadNukesitePanel Singleton;

	private bool _doorFound;

	private DoorNametagExtension _outsideDoor;

	public bool AnyBlastdoorClosed
	{
		get
		{
			foreach (BlastDoor instance in BlastDoor.Instances)
			{
				if (!instance.IsOpen)
				{
					return true;
				}
			}
			return false;
		}
	}

	private bool OutsideDoorOpen
	{
		get
		{
			if (!_doorFound)
			{
				_doorFound = DoorNametagExtension.NamedDoors.TryGetValue("SURFACE_NUKE", out _outsideDoor);
			}
			if (_doorFound)
			{
				return _outsideDoor.TargetDoor.TargetState;
			}
			return false;
		}
	}

	public IVerificationRule VerificationRule => StandardDistanceVerification.Default;

	public bool Networkenabled
	{
		get
		{
			return enabled;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref enabled, 1uL, null);
		}
	}

	private void Awake()
	{
		Singleton = this;
		int num = _ledRenderer.sharedMaterials.Length;
		_matSet = new Material[num];
		_prevMats = new bool[num];
		for (int i = 0; i < num; i++)
		{
			_matSet[i] = _offMat;
		}
	}

	public void ServerInteract(ReferenceHub ply, byte colliderId)
	{
		switch ((PanelColliderId)colliderId)
		{
		case PanelColliderId.Cancel:
			AlphaWarheadController.Singleton.CancelDetonation(ply);
			ServerLogs.AddLog(ServerLogs.Modules.Warhead, ply.LoggedNameFromRefHub() + " cancelled the Alpha Warhead detonation.", ServerLogs.ServerLogType.GameEvent);
			break;
		case PanelColliderId.Lever:
			if (!(_leverStatus > 0f) || !(_leverStatus < 1f))
			{
				bool flag = !enabled;
				PlayerInteractingWarheadLeverEventArgs e = new PlayerInteractingWarheadLeverEventArgs(ply, flag);
				PlayerEvents.OnInteractingWarheadLever(e);
				if (e.IsAllowed)
				{
					flag = (Networkenabled = e.Enabled);
					RpcLeverSound();
					ServerLogs.AddLog(ServerLogs.Modules.Warhead, ply.LoggedNameFromRefHub() + " set the Alpha Warhead status to " + enabled + ".", ServerLogs.ServerLogType.GameEvent);
					PlayerEvents.OnInteractedWarheadLever(new PlayerInteractedWarheadLeverEventArgs(ply, flag));
				}
			}
			break;
		}
	}

	private void SetDiode(DiodeType diode, bool status)
	{
		if (_prevMats[(int)diode] != status)
		{
			_matSet[(int)diode] = (status ? _onMat : _offMat);
			_prevMats[(int)diode] = status;
			_anyModified = true;
		}
	}

	private void Update()
	{
		_anyModified = false;
		SetDiode(DiodeType.InProgress, AlphaWarheadController.InProgress);
		SetDiode(DiodeType.OutsideDoor, OutsideDoorOpen);
		SetDiode(DiodeType.BlastDoor, AnyBlastdoorClosed);
		if (_anyModified)
		{
			_ledRenderer.sharedMaterials = _matSet;
		}
		_leverStatus += (enabled ? 0.04f : (-0.04f));
		_leverStatus = Mathf.Clamp01(_leverStatus);
		lever.localRotation = Quaternion.Slerp(_disabledLeverRotation, _enabledLeverRotation, _leverStatus);
	}

	[ClientRpc]
	private void RpcLeverSound()
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		SendRPCInternal("System.Void AlphaWarheadNukesitePanel::RpcLeverSound()", 791711933, writer, 0, includeOwner: true);
		NetworkWriterPool.Return(writer);
	}

	public override bool Weaved()
	{
		return true;
	}

	protected void UserCode_RpcLeverSound()
	{
	}

	protected static void InvokeUserCode_RpcLeverSound(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("RPC RpcLeverSound called on server.");
		}
		else
		{
			((AlphaWarheadNukesitePanel)obj).UserCode_RpcLeverSound();
		}
	}

	static AlphaWarheadNukesitePanel()
	{
		RemoteProcedureCalls.RegisterRpc(typeof(AlphaWarheadNukesitePanel), "System.Void AlphaWarheadNukesitePanel::RpcLeverSound()", InvokeUserCode_RpcLeverSound);
	}

	protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
	{
		base.SerializeSyncVars(writer, forceAll);
		if (forceAll)
		{
			writer.WriteBool(enabled);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteBool(enabled);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref enabled, null, reader.ReadBool());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref enabled, null, reader.ReadBool());
		}
	}
}
