using System;
using System.Collections.Generic;
using Mirror;
using Mirror.RemoteCalls;
using Security;
using UnityEngine;

public class AmbientSoundPlayer : NetworkBehaviour
{
	[Serializable]
	public class AmbientClip
	{
		public AudioClip clip;

		public bool repeatable = true;

		public bool is3D = true;

		public bool played;

		public int index;
	}

	public GameObject audioPrefab;

	public int minTime = 30;

	public int maxTime = 60;

	public AmbientClip[] clips;

	private List<AmbientClip> list = new List<AmbientClip>();

	private RateLimit _ambientSoundRateLimit = new RateLimit(4, 3f);

	private void Start()
	{
		if (base.isLocalPlayer && base.isServer)
		{
			for (int i = 0; i < clips.Length; i++)
			{
				clips[i].index = i;
			}
			Invoke("GenerateRandom", 10f);
		}
	}

	private void GenerateRandom()
	{
		list.Clear();
		int num = 0;
		AmbientClip[] array = clips;
		foreach (AmbientClip ambientClip in array)
		{
			if (!ambientClip.played)
			{
				list.Add(ambientClip);
			}
		}
		num = UnityEngine.Random.Range(0, list.Count);
		int index = list[num].index;
		if (!clips[index].repeatable)
		{
			clips[index].played = true;
		}
		RpcPlaySound(index);
		Invoke("GenerateRandom", UnityEngine.Random.Range(minTime, maxTime));
	}

	private void PlaySound(int clipId)
	{
		GameObject gameObject = UnityEngine.Object.Instantiate(audioPrefab);
		Vector3 vector = new Vector3(UnityEngine.Random.Range(-1, 1), 0f, UnityEngine.Random.Range(-1, 1)).normalized * 200f;
		gameObject.transform.position = base.transform.position + vector;
		gameObject.GetComponent<AudioSource>().clip = clips[clipId].clip;
		gameObject.GetComponent<AudioSource>().spatialBlend = (clips[clipId].is3D ? 1 : 0);
		gameObject.GetComponent<AudioSource>().Play();
		UnityEngine.Object.Destroy(gameObject, 10f);
	}

	[ClientRpc]
	private void RpcPlaySound(int id)
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		writer.WriteInt(id);
		SendRPCInternal("System.Void AmbientSoundPlayer::RpcPlaySound(System.Int32)", -1494438428, writer, 0, includeOwner: true);
		NetworkWriterPool.Return(writer);
	}

	public override bool Weaved()
	{
		return true;
	}

	protected void UserCode_RpcPlaySound__Int32(int id)
	{
		if (_ambientSoundRateLimit.CanExecute())
		{
			PlaySound(id);
		}
	}

	protected static void InvokeUserCode_RpcPlaySound__Int32(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("RPC RpcPlaySound called on server.");
		}
		else
		{
			((AmbientSoundPlayer)obj).UserCode_RpcPlaySound__Int32(reader.ReadInt());
		}
	}

	static AmbientSoundPlayer()
	{
		RemoteProcedureCalls.RegisterRpc(typeof(AmbientSoundPlayer), "System.Void AmbientSoundPlayer::RpcPlaySound(System.Int32)", InvokeUserCode_RpcPlaySound__Int32);
	}
}
