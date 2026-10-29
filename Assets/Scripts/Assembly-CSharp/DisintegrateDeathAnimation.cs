using System.Collections.Generic;
using DeathAnimations;
using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

public class DisintegrateDeathAnimation : DeathAnimation
{
	public interface IDisintegrateDamageHandler
	{
		bool Disintegrate { get; }
	}

	private const float DisolveSpeed = 1.5f;

	private const int TargetLayerMask = 1;

	private const float FlySpeed = 2f;

	private static readonly int DissolveHash = Shader.PropertyToID("_Dissolve");

	[SerializeField]
	private Material _templateMaterial;

	private List<Material> _materials;

	private bool _initialize;

	private float _timer;

	protected override void OnAnimationStarted()
	{
		if (!(base.TargetRagdoll.Info.Handler is IDisintegrateDamageHandler { Disintegrate: not false }))
		{
			base.enabled = false;
			return;
		}
		_materials = new List<Material>();
		CharacterModelUtils.ConvertRagdoll(base.TargetRagdoll, ProcessRenderer, _templateMaterial, _materials);
		Rigidbody[] componentsInChildren = GetComponentsInChildren<Rigidbody>();
		foreach (Rigidbody rigidbody in componentsInChildren)
		{
			rigidbody.useGravity = false;
			rigidbody.linearVelocity = rigidbody.linearVelocity / 10f + Vector3.up * 2f * Random.value;
		}
		Collider[] componentsInChildren2 = GetComponentsInChildren<Collider>();
		for (int i = 0; i < componentsInChildren2.Length; i++)
		{
			componentsInChildren2[i].enabled = false;
		}
		_initialize = true;
	}

	private bool ProcessRenderer(Renderer rend, List<Material> materials)
	{
		if (rend is ParticleSystemRenderer)
		{
			rend.enabled = false;
			return false;
		}
		rend.gameObject.layer = 1;
		return true;
	}

	private void Update()
	{
		if (!_initialize)
		{
			return;
		}
		_timer += Time.deltaTime;
		foreach (Material material in _materials)
		{
			material.SetFloat(DissolveHash, Mathf.Clamp01(_timer / 1.5f));
		}
		if (_timer > 1.5f)
		{
			base.enabled = false;
		}
	}
}
