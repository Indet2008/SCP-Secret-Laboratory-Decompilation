using System.Runtime.InteropServices;
using GameCore;
using Mirror;
using UnityEngine;

public class ServerTime : NetworkBehaviour
{
	[SyncVar]
	public int timeFromStartup;

	public static int time;

	private const int AllowedDeviation = 2;

	private bool _rateLimit;

	public int NetworktimeFromStartup
	{
		get
		{
			return timeFromStartup;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref timeFromStartup, 1uL, null);
		}
	}

	public static bool CheckSynchronization(int myTime)
	{
		int num = Mathf.Abs(myTime - time);
		if (num > 2)
		{
			Console.AddLog("Damage sync error.", new Color32(byte.MaxValue, 200, 0, byte.MaxValue));
		}
		return num <= 2;
	}

	private void Update()
	{
		_rateLimit = false;
		if (timeFromStartup != 0)
		{
			time = timeFromStartup;
		}
	}

	private void Start()
	{
		if (base.isLocalPlayer && NetworkServer.active)
		{
			InvokeRepeating("IncreaseTime", 1f, 1f);
		}
	}

	private void IncreaseTime()
	{
		NetworktimeFromStartup = timeFromStartup + 1;
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
			writer.WriteInt(timeFromStartup);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteInt(timeFromStartup);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref timeFromStartup, null, reader.ReadInt());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref timeFromStartup, null, reader.ReadInt());
		}
	}
}
