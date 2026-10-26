using System.Runtime.InteropServices;
using Mirror;
using UnityEngine;

public class SkyboxHubert : NetworkBehaviour
{
	private const int Chance = 250;

	[SyncVar(hook = "HubertHook")]
	public bool Hubert;

	[SerializeField]
	private MeshRenderer _skyboxMeshRenderer;

	[SerializeField]
	private Material _hubertSkybox;

	private static SkyboxHubert _singleton;

	public bool NetworkHubert
	{
		get
		{
			return Hubert;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref Hubert, 1uL, HubertHook);
		}
	}

	private void Awake()
	{
		_singleton = this;
	}

	[RuntimeInitializeOnLoadMethod]
	private static void Init()
	{
		CharacterClassManager.OnRoundStarted += CharacterClassManager_OnRoundStarted;
	}

	private static void CharacterClassManager_OnRoundStarted()
	{
		if (NetworkServer.active && Random.Range(0, 250) == 249 && !(_singleton == null))
		{
			_singleton.NetworkHubert = true;
		}
	}

	private void HubertHook(bool old, bool newValue)
	{
		if (newValue && _skyboxMeshRenderer != null)
		{
			_skyboxMeshRenderer.sharedMaterial = _hubertSkybox;
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
			writer.WriteBool(Hubert);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteBool(Hubert);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref Hubert, HubertHook, reader.ReadBool());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref Hubert, HubertHook, reader.ReadBool());
		}
	}
}
