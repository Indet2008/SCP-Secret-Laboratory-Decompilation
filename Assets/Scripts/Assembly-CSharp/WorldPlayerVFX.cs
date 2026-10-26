using System;
using System.Collections.Generic;
using UnityEngine;

public class WorldPlayerVFX : MonoBehaviour
{
	[Serializable]
	private struct WorldPlayerParticleSystem
	{
		public ParticleSystem ParticleSystem;

		[Tooltip("This is how much velocity to apply to the particleEffect if the player is not moving on the Z axis.")]
		public float BaseVelocity;

		[Tooltip("This is how much velocity to add or substract from the baseVelocity if the player is moving on the Z axis.")]
		public float AddVelocity;
	}

	private const float Threshold = 0.01f;

	[SerializeField]
	private List<WorldPlayerParticleSystem> _particleSystems;

	[SerializeField]
	[Tooltip("Once this much time in seconds passes, the particle gameObject will be destroyed.")]
	private float _particleLifetime = 8f;

	private ReferenceHub _hub;

	private int _movingForwardDir;

	private float _currentTime;

	private Vector3 _lastPos;

	public void Assign(ReferenceHub hub)
	{
		_hub = hub;
	}

	private void Start()
	{
		foreach (WorldPlayerParticleSystem particleSystem in _particleSystems)
		{
			ParticleSystem.MainModule main = particleSystem.ParticleSystem.main;
			main.startSpeed = particleSystem.BaseVelocity + _hub.PlayerCameraReference.transform.forward.z * particleSystem.AddVelocity;
			particleSystem.ParticleSystem.Play();
		}
		_lastPos = _hub.PlayerCameraReference.transform.position;
	}

	private void Update()
	{
		AddVelocityToParticles();
		_currentTime += Time.deltaTime;
		if (_currentTime >= _particleLifetime)
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}

	private void AddVelocityToParticles()
	{
		Vector3 rhs = _hub.PlayerCameraReference.transform.position - _lastPos;
		_lastPos = _hub.PlayerCameraReference.transform.position;
		if (rhs.magnitude < 0.01f)
		{
			_movingForwardDir = 0;
		}
		else
		{
			_movingForwardDir = ((Vector3.Dot(_hub.PlayerCameraReference.transform.forward, rhs) > 0f) ? 1 : (-1));
		}
		foreach (WorldPlayerParticleSystem particleSystem in _particleSystems)
		{
			ParticleSystem.MainModule main = particleSystem.ParticleSystem.main;
			main.startSpeed = particleSystem.BaseVelocity + (float)_movingForwardDir * particleSystem.AddVelocity;
		}
	}
}
