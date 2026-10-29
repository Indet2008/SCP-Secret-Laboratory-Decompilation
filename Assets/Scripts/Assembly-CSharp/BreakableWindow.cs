using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using Footprinting;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using MapGeneration.StaticHelpers;
using Mirror;
using PlayerRoles;
using PlayerStatsSystem;
using UnityEngine;
using UnityEngine.Rendering;

public class BreakableWindow : NetworkBehaviour, IDestructible, IBlockStaticBatching
{
	public static Action<BreakableWindow> OnAdded;

	public static Action<BreakableWindow> OnDestroyed;

	public Footprint LastAttacker;

	public float Health = 30f;

	[SyncVar]
	public bool IsBroken;

	public GameObject Template;

	public Transform Parent;

	[SerializeField]
	private bool _preventScpDamage;

	private readonly List<MeshRenderer> _meshRenderers = new List<MeshRenderer>();

	private bool _prevStatus;

	public uint NetworkId => base.netId;

	public Vector3 CenterOfMass => base.transform.position;

	public bool NetworkIsBroken
	{
		get
		{
			return IsBroken;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref IsBroken, 1uL, null);
		}
	}

	public bool Damage(float damage, DamageHandlerBase handler, Vector3 pos)
	{
		if (!(handler is AttackerDamageHandler attackerDamageHandler))
		{
			ServerDamageWindow(damage);
			return true;
		}
		if (!CheckDamagePerms(attackerDamageHandler.Attacker.Role))
		{
			return false;
		}
		PlayerDamagingWindowEventArgs e = new PlayerDamagingWindowEventArgs(attackerDamageHandler.Attacker.Hub, this, handler);
		PlayerEvents.OnDamagingWindow(e);
		if (!e.IsAllowed)
		{
			return false;
		}
		LastAttacker = attackerDamageHandler.Attacker;
		ServerDamageWindow(damage);
		PlayerEvents.OnDamagedWindow(new PlayerDamagedWindowEventArgs(attackerDamageHandler.Attacker.Hub, this, handler));
		return true;
	}

	private void Awake()
	{
		_meshRenderers.AddRange(GetComponentsInChildren<MeshRenderer>());
		GetComponent<Collider>().enabled = false;
		Invoke("EnableColliders", 1f);
	}

	private void EnableColliders()
	{
		GetComponent<Collider>().enabled = true;
	}

	private void Start()
	{
		OnAdded?.Invoke(this);
	}

	private void OnDestroy()
	{
		OnDestroyed?.Invoke(this);
	}

	private void Update()
	{
		if (IsBroken && !_prevStatus)
		{
			StartCoroutine(BreakWindow());
			_prevStatus = true;
		}
	}

	private void LateUpdate()
	{
		for (int num = _meshRenderers.Count - 1; num >= 0; num--)
		{
			MeshRenderer meshRenderer = _meshRenderers[num];
			meshRenderer.shadowCastingMode = (IsBroken ? ShadowCastingMode.ShadowsOnly : ShadowCastingMode.Off);
			if (IsBroken)
			{
				_meshRenderers.RemoveAt(num);
				UnityEngine.Object.Destroy(meshRenderer);
			}
			meshRenderer.gameObject.layer = (IsBroken ? 28 : 14);
		}
	}

	private IEnumerator BreakWindow()
	{
		Collider[] componentsInChildren = GetComponentsInChildren<Collider>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].enabled = false;
		}
		GameObject obj = UnityEngine.Object.Instantiate(Template, Parent);
		obj.transform.localScale = Vector3.one;
		obj.transform.SetLocalPositionAndRotation(Vector3.zero, Quaternion.Euler(Vector3.zero));
		Rigidbody[] rbs = obj.GetComponentsInChildren<Rigidbody>();
		List<Vector3> scales = NorthwoodLib.Pools.ListPool<Vector3>.Shared.Rent();
		Rigidbody[] array = rbs;
		foreach (Rigidbody rigidbody in array)
		{
			rigidbody.angularVelocity = new Vector3(UnityEngine.Random.Range(-360, 360), UnityEngine.Random.Range(-360, 360), UnityEngine.Random.Range(-360, 360));
			rigidbody.linearVelocity = new Vector3(UnityEngine.Random.Range(-2, 2), UnityEngine.Random.Range(-2, 2), UnityEngine.Random.Range(-2, 2));
			scales.Add(rigidbody.transform.localScale);
		}
		for (int i = 0; i < 250; i++)
		{
			for (int j = 0; j < scales.Count; j++)
			{
				rbs[j].transform.localScale = Vector3.Lerp(scales[j], scales[j] * 0.5f, (float)i / 75f);
			}
			yield return null;
		}
		for (float f = 0f; f < 150f; f += 1f)
		{
			for (int k = 0; k < scales.Count; k++)
			{
				rbs[k].transform.localScale = Vector3.Lerp(scales[k] * 0.5f, Vector3.zero, f / 150f);
			}
			yield return null;
		}
		NorthwoodLib.Pools.ListPool<Vector3>.Shared.Return(scales);
		array = rbs;
		foreach (Rigidbody rigidbody2 in array)
		{
			UnityEngine.Object.Destroy(rigidbody2.gameObject, 1f);
		}
	}

	private bool CheckDamagePerms(RoleTypeId roleType)
	{
		if (!_preventScpDamage)
		{
			return true;
		}
		if (!roleType.TryGetRoleTemplate<PlayerRoleBase>(out var result))
		{
			return false;
		}
		return result.Team != Team.SCPs;
	}

	[ServerCallback]
	private void ServerDamageWindow(float damage)
	{
		if (NetworkServer.active)
		{
			Health -= damage;
			if (Health <= 0f)
			{
				NetworkIsBroken = true;
			}
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
			writer.WriteBool(IsBroken);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteBool(IsBroken);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref IsBroken, null, reader.ReadBool());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref IsBroken, null, reader.ReadBool());
		}
	}
}
