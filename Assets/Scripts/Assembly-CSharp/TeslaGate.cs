using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using Hazards;
using MEC;
using MapGeneration;
using Mirror;
using Mirror.RemoteCalls;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

public class TeslaGate : NetworkBehaviour
{
	public delegate void BurstComplete(ReferenceHub hub, TeslaGate teslaGate);

	public Vector3 localPosition;

	public Vector3 localRotation;

	public GameObject[] killers;

	public LayerMask killerMask;

	public bool InProgress;

	public Animator ledLights;

	public ParticleSystem[] windupParticles;

	public ParticleSystem[] shockParticles;

	public ParticleSystem[] smokeParticles;

	public static readonly HashSet<TeslaGate> AllGates;

	public RoomIdentifier Room;

	private Vector3 _position;

	[Header("Parameters")]
	public Vector3 sizeOfKiller;

	public float sizeOfTrigger;

	public float distanceToIdle;

	public float windupTime;

	public float cooldownTime;

	[Header("Idle Loop")]
	public bool isIdling;

	public AudioSource loopSource;

	public AudioClip idleStart;

	public AudioClip idleLoop;

	public AudioClip idleEnd;

	[Header("Audio")]
	public AudioSource source;

	public AudioClip[] clipsWarmup;

	public AudioClip[] clipsShock;

	public bool showGizmos;

	[SyncVar]
	public float InactiveTime;

	public List<TantrumEnvironmentalHazard> TantrumsToBeDestroyed = new List<TantrumEnvironmentalHazard>();

	private bool next079burst;

	private static readonly int _animatorShockHash;

	private static readonly int _animatorIdleHash;

	public Vector3 Position
	{
		get
		{
			if (_position == Vector3.zero)
			{
				_position = base.transform.position;
			}
			return _position;
		}
	}

	public float NetworkInactiveTime
	{
		get
		{
			return InactiveTime;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref InactiveTime, 1uL, null);
		}
	}

	public static event BurstComplete OnBurstComplete;

	public static event Action<TeslaGate> OnAdded;

	public static event Action<TeslaGate> OnRemoved;

	public static event Action<TeslaGate> OnBursted;

	public void ServerSideCode()
	{
		if (!InProgress)
		{
			Timing.RunCoroutine(ServerSideWaitForAnimation());
			RpcPlayAnimation();
		}
	}

	private IEnumerator<float> ServerSideWaitForAnimation()
	{
		InProgress = true;
		yield return Timing.WaitForSeconds(windupTime);
		if (TantrumsToBeDestroyed.Count > 0)
		{
			TantrumsToBeDestroyed.ForEach((TantrumEnvironmentalHazard tantrum) =>
			{
				if (tantrum != null)
				{
					tantrum.PlaySizzle = true;
					tantrum.ServerDestroy();
				}
			});
			TantrumsToBeDestroyed.Clear();
		}
		yield return Timing.WaitForSeconds(cooldownTime);
		InProgress = false;
	}

	public void ServerSideIdle(bool shouldIdle)
	{
		if (shouldIdle)
		{
			RpcDoIdle();
		}
		else
		{
			RpcDoneIdling();
		}
	}

	private void Update()
	{
	}

	private void Start()
	{
		AllGates.Add(this);
		OnAdded?.Invoke(this);
	}

	private void OnDestroy()
	{
		AllGates.Remove(this);
		OnRemoved?.Invoke(this);
	}

	public void ClientSideCode()
	{
		base.transform.localPosition = localPosition;
		base.transform.localRotation = Quaternion.Euler(localRotation);
		if (ledLights != null)
		{
			ledLights.SetBool(_animatorShockHash, InProgress);
			ledLights.SetBool(_animatorIdleHash, isIdling);
		}
	}

	[ClientRpc]
	private void RpcDoIdle()
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		SendRPCInternal("System.Void TeslaGate::RpcDoIdle()", 482546151, writer, 0, includeOwner: true);
		NetworkWriterPool.Return(writer);
	}

	[ClientRpc]
	private void RpcDoneIdling()
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		SendRPCInternal("System.Void TeslaGate::RpcDoneIdling()", -243325925, writer, 0, includeOwner: true);
		NetworkWriterPool.Return(writer);
	}

	[ClientRpc]
	private void RpcPlayAnimation()
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		SendRPCInternal("System.Void TeslaGate::RpcPlayAnimation()", 2031582250, writer, 0, includeOwner: true);
		NetworkWriterPool.Return(writer);
	}

	[ClientRpc]
	public void RpcInstantBurst()
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		SendRPCInternal("System.Void TeslaGate::RpcInstantBurst()", -684941977, writer, 0, includeOwner: true);
		NetworkWriterPool.Return(writer);
	}

	private IEnumerator<float> _DoShock()
	{
		OnBursted?.Invoke(this);
		source.Stop();
		AudioClip[] array = clipsShock;
		foreach (AudioClip audioClip in array)
		{
			if (audioClip != null)
			{
				source.PlayOneShot(audioClip);
			}
		}
		ParticleSystem[] array2 = windupParticles;
		foreach (ParticleSystem particleSystem in array2)
		{
			if (particleSystem != null)
			{
				particleSystem.Play();
			}
		}
		array2 = shockParticles;
		foreach (ParticleSystem particleSystem2 in array2)
		{
			if (particleSystem2 != null)
			{
				particleSystem2.Play();
			}
		}
		ReferenceHub hub;
		while (!ReferenceHub.TryGetLocalHub(out hub))
		{
			yield return float.NegativeInfinity;
		}
		_ = hub.gameObject;
		yield return Timing.WaitForSeconds(0.25f);
		yield return Timing.WaitForSeconds(0.25f);
		float num = 0f;
		array2 = smokeParticles;
		foreach (ParticleSystem particleSystem3 in array2)
		{
			if (!(particleSystem3 == null))
			{
				if (particleSystem3.IsAlive() && num <= 0f)
				{
					num = particleSystem3.main.duration;
				}
				particleSystem3.Play();
			}
		}
		if (!isIdling)
		{
			array2 = windupParticles;
			foreach (ParticleSystem particleSystem4 in array2)
			{
				if (particleSystem4 != null)
				{
					particleSystem4.Stop();
				}
			}
		}
		yield return Timing.WaitForSeconds(num);
	}

	private IEnumerator<float> _PlayAnimation()
	{
		bool is079 = next079burst;
		next079burst = false;
		if (!is079)
		{
			AudioClip[] array = clipsWarmup;
			foreach (AudioClip clip in array)
			{
				source.PlayOneShot(clip);
			}
			ParticleSystem[] array2 = windupParticles;
			for (int i = 0; i < array2.Length; i++)
			{
				array2[i].Play();
			}
			yield return Timing.WaitForSeconds(windupTime);
		}
		Timing.RunCoroutine(_DoShock());
		yield return Timing.WaitForSeconds(is079 ? 0.5f : cooldownTime);
	}

	public bool PlayerInRange(ReferenceHub player)
	{
		if (player.roleManager.CurrentRole is ITeslaControllerRole { CanActivateShock: false })
		{
			return false;
		}
		if (!(player.roleManager.CurrentRole is IFpcRole fpcRole))
		{
			return false;
		}
		return InRange(fpcRole.FpcModule.Position);
	}

	private bool InRange(Vector3 position)
	{
		return Vector3.Distance(Position, position) < sizeOfTrigger;
	}

	public bool IsInIdleRange(ReferenceHub player)
	{
		if (!player.IsAlive())
		{
			return false;
		}
		if (player.roleManager.CurrentRole is ITeslaControllerRole teslaControllerRole)
		{
			return teslaControllerRole.IsInIdleRange(this);
		}
		if (!(player.roleManager.CurrentRole is IFpcRole fpcRole))
		{
			return false;
		}
		return IsInIdleRange(fpcRole.FpcModule.Position);
	}

	public bool IsInIdleRange(Vector3 position)
	{
		return Vector3.Distance(Position, position) < distanceToIdle;
	}

	private void OnDrawGizmosSelected()
	{
		if (showGizmos)
		{
			Gizmos.color = new Color(1f, 0f, 0f, 0.2f);
			GameObject[] array = killers;
			for (int i = 0; i < array.Length; i++)
			{
				Gizmos.DrawCube(array[i].transform.position + Vector3.up * (sizeOfKiller.y / 2f), sizeOfKiller);
			}
			Gizmos.color = new Color(1f, 1f, 0f, 0.2f);
			Gizmos.DrawSphere(Position, sizeOfTrigger);
		}
	}

	static TeslaGate()
	{
		AllGates = new HashSet<TeslaGate>();
		_animatorShockHash = Animator.StringToHash("ShockActive");
		_animatorIdleHash = Animator.StringToHash("IdleActive");
		RemoteProcedureCalls.RegisterRpc(typeof(TeslaGate), "System.Void TeslaGate::RpcDoIdle()", InvokeUserCode_RpcDoIdle);
		RemoteProcedureCalls.RegisterRpc(typeof(TeslaGate), "System.Void TeslaGate::RpcDoneIdling()", InvokeUserCode_RpcDoneIdling);
		RemoteProcedureCalls.RegisterRpc(typeof(TeslaGate), "System.Void TeslaGate::RpcPlayAnimation()", InvokeUserCode_RpcPlayAnimation);
		RemoteProcedureCalls.RegisterRpc(typeof(TeslaGate), "System.Void TeslaGate::RpcInstantBurst()", InvokeUserCode_RpcInstantBurst);
	}

	public override bool Weaved()
	{
		return true;
	}

	protected void UserCode_RpcDoIdle()
	{
		if (!isIdling)
		{
			isIdling = true;
			loopSource.PlayOneShot(idleStart);
			loopSource.PlayDelayed(idleStart.length);
		}
		ParticleSystem[] array = windupParticles;
		foreach (ParticleSystem particleSystem in array)
		{
			if (!particleSystem.isPlaying)
			{
				particleSystem.Play();
			}
		}
	}

	protected static void InvokeUserCode_RpcDoIdle(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("RPC RpcDoIdle called on server.");
		}
		else
		{
			((TeslaGate)obj).UserCode_RpcDoIdle();
		}
	}

	protected void UserCode_RpcDoneIdling()
	{
		if (isIdling)
		{
			isIdling = false;
			loopSource.Stop();
			loopSource.PlayOneShot(idleEnd);
			ParticleSystem[] array = windupParticles;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].Stop();
			}
		}
	}

	protected static void InvokeUserCode_RpcDoneIdling(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("RPC RpcDoneIdling called on server.");
		}
		else
		{
			((TeslaGate)obj).UserCode_RpcDoneIdling();
		}
	}

	protected void UserCode_RpcPlayAnimation()
	{
		Timing.RunCoroutine(_PlayAnimation(), Segment.FixedUpdate);
	}

	protected static void InvokeUserCode_RpcPlayAnimation(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("RPC RpcPlayAnimation called on server.");
		}
		else
		{
			((TeslaGate)obj).UserCode_RpcPlayAnimation();
		}
	}

	protected void UserCode_RpcInstantBurst()
	{
		next079burst = true;
		Timing.RunCoroutine(_PlayAnimation(), Segment.FixedUpdate);
	}

	protected static void InvokeUserCode_RpcInstantBurst(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("RPC RpcInstantBurst called on server.");
		}
		else
		{
			((TeslaGate)obj).UserCode_RpcInstantBurst();
		}
	}

	protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
	{
		base.SerializeSyncVars(writer, forceAll);
		if (forceAll)
		{
			writer.WriteFloat(InactiveTime);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteFloat(InactiveTime);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref InactiveTime, null, reader.ReadFloat());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref InactiveTime, null, reader.ReadFloat());
		}
	}
}
