using System.Runtime.InteropServices;
using Interactables.Interobjects;
using Mirror;
using Mirror.RemoteCalls;
using UnityEngine;

public class SqueakSpawner : NetworkBehaviour
{
	[SerializeField]
	private int spawnChancePercent = 10;

	[SerializeField]
	private GameObject[] mice;

	[SyncVar(hook = "SyncMouseSpawn")]
	private byte syncSpawn;

	private SqueakInteraction _spawnedMouse;

	public byte NetworksyncSpawn
	{
		get
		{
			return syncSpawn;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref syncSpawn, 1uL, SyncMouseSpawn);
		}
	}

	private void Awake()
	{
		if (NetworkServer.active && Random.Range(0, 100) <= spawnChancePercent)
		{
			NetworksyncSpawn = (byte)Random.Range(1, mice.Length + 1);
			SyncMouseSpawn(0, syncSpawn);
		}
	}

	[TargetRpc]
	public void TargetHitMouse(NetworkConnection networkConnection)
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		SendTargetRPCInternal(networkConnection, "System.Void SqueakSpawner::TargetHitMouse(Mirror.NetworkConnection)", 1242807795, writer, 0);
		NetworkWriterPool.Return(writer);
	}

	private void SyncMouseSpawn(byte oldValue, byte newValue)
	{
		if (newValue != 0)
		{
			GameObject gameObject = mice[newValue - 1];
			gameObject.SetActive(value: true);
			_spawnedMouse = gameObject.GetComponent<SqueakInteraction>();
		}
	}

	public override bool Weaved()
	{
		return true;
	}

	protected void UserCode_TargetHitMouse__NetworkConnection(NetworkConnection networkConnection)
	{
		if (_spawnedMouse != null && _spawnedMouse.enabled)
		{
			_spawnedMouse.ClientInteract(null);
			_spawnedMouse.gameObject.SetActive(value: false);
		}
	}

	protected static void InvokeUserCode_TargetHitMouse__NetworkConnection(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("TargetRPC TargetHitMouse called on server.");
		}
		else
		{
			((SqueakSpawner)obj).UserCode_TargetHitMouse__NetworkConnection(null);
		}
	}

	static SqueakSpawner()
	{
		RemoteProcedureCalls.RegisterRpc(typeof(SqueakSpawner), "System.Void SqueakSpawner::TargetHitMouse(Mirror.NetworkConnection)", InvokeUserCode_TargetHitMouse__NetworkConnection);
	}

	protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
	{
		base.SerializeSyncVars(writer, forceAll);
		if (forceAll)
		{
			NetworkWriterExtensions.WriteByte(writer, syncSpawn);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			NetworkWriterExtensions.WriteByte(writer, syncSpawn);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref syncSpawn, SyncMouseSpawn, NetworkReaderExtensions.ReadByte(reader));
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref syncSpawn, SyncMouseSpawn, NetworkReaderExtensions.ReadByte(reader));
		}
	}
}
