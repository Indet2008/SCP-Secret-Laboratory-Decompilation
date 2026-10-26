using System;
using InventorySystem.Items.MicroHID.Modules;
using UnityEngine;

namespace InventorySystem.Items.MicroHID
{
	public class MicroHIDParticles : MonoBehaviour
	{
		[Serializable]
		private struct WindupArc
		{
			[SerializeField]
			private ParticleSystem _particleSys;

			[SerializeField]
			private AnimationCurve _emissionRateOverProgress;

			public readonly void Update(float windupProgress)
			{
				float constant = _emissionRateOverProgress.Evaluate(windupProgress);
				ParticleSystem.EmissionModule emission = _particleSys.emission;
				emission.rateOverTime = new ParticleSystem.MinMaxCurve(constant);
			}
		}

		[Serializable]
		private struct AimedLaser
		{
			[SerializeField]
			private ParticleSystem _particleSys;

			[SerializeField]
			private bool _viewmodelMode;

			private const float MinDot = 0.6f;

			public readonly void SetActive(bool b)
			{
				_particleSys.gameObject.SetActive(b);
			}

			public readonly void Update(MicroHIDParticles parts, FiringModeControllerModule firingMode, float scale)
			{
				ParticleSystem.TrailModule trails = _particleSys.trails;
				trails.widthOverTrail = parts._targetTrailWidth * scale;
				float targetLength;
				if (_viewmodelMode)
				{
					targetLength = firingMode.FiringRange;
				}
				else
				{
					GetTransformationData(parts._camera, firingMode.FiringRange, out targetLength, out var targetFwd);
					_particleSys.transform.forward = targetFwd;
				}
				ParticleSystem.MainModule main = _particleSys.main;
				main.startLifetime = targetLength * parts._rangeToLifetimeRatio * scale;
			}

			private readonly void GetTransformationData(Transform camera, float firingRange, out float targetLength, out Vector3 targetFwd)
			{
				Vector3 position = camera.position;
				Vector3 forward = camera.forward;
				Transform transform = _particleSys.transform;
				targetFwd = forward;
				targetLength = 0f;
				Vector3 vector = (Physics.Raycast(position, forward, out var hitInfo, firingRange, VisualizedCollisionMask) ? hitInfo.point : (position + forward * firingRange)) - transform.position;
				float magnitude = vector.magnitude;
				if (magnitude != 0f)
				{
					targetFwd = vector / magnitude;
					if (!(Vector3.Dot(targetFwd, forward) < 0.6f))
					{
						targetLength = magnitude;
					}
				}
			}
		}

		private static readonly CachedLayerMask VisualizedCollisionMask = new CachedLayerMask("Default", "Glass", "Door");

		[SerializeField]
		private GameObject _allParticles;

		[SerializeField]
		private float _rangeToLifetimeRatio;

		[SerializeField]
		private float _targetTrailWidth;

		[SerializeField]
		private ParticleSystem _breakParticles;

		[SerializeField]
		private AimedLaser[] _lasers;

		[SerializeField]
		private GameObject _chargeFireExtras;

		[SerializeField]
		private ParticleSystem[] _startFiringParticles;

		[SerializeField]
		private WindupArc[] _windupArcs;

		[SerializeField]
		private ParticleSystem _windupBlinkerSystem;

		[SerializeField]
		private Gradient _windupBlinkerGradient;

		[SerializeField]
		private float _arcGrowTime;

		private bool _initalized;

		private ushort _serial;

		private CycleController _cycle;

		private MicroHidPhase _prevPhase;

		private bool _wasBroken;

		private Transform _camera;

		private const float BreakAnimTime = 5f;

		private bool WasFiring
		{
			get
			{
				if (!_cycle.TryGetElapsed(MicroHidPhase.WindingUp, out var elapsed))
				{
					return false;
				}
				if (!_cycle.TryGetElapsed(MicroHidPhase.Firing, out var elapsed2))
				{
					return false;
				}
				return elapsed > elapsed2;
			}
		}

		public void Init(ushort serial, Transform camera)
		{
			_initalized = true;
			_serial = serial;
			_camera = camera;
			_cycle = CycleSyncModule.GetCycleController(serial);
		}

		private void Update()
		{
			if (_initalized)
			{
				UpdateAll();
				_prevPhase = _cycle.Phase;
			}
		}

		private void UpdateAll()
		{
			bool flag = _cycle.Phase != MicroHidPhase.Standby;
			_allParticles.SetActive(flag);
			if (!flag)
			{
				_wasBroken = false;
				return;
			}
			UpdateBroken();
			UpdateFiring();
			float num = (_wasBroken ? 0f : WindupSyncModule.GetProgress(_serial));
			ParticleSystem.MainModule main = _windupBlinkerSystem.main;
			main.startColor = _windupBlinkerGradient.Evaluate(num);
			WindupArc[] windupArcs = _windupArcs;
			foreach (WindupArc windupArc in windupArcs)
			{
				windupArc.Update(num);
			}
		}

		private void UpdateFiring()
		{
			bool num = _cycle.Phase == MicroHidPhase.Firing;
			MicroHidPhase prevPhase = _prevPhase;
			bool flag = prevPhase == MicroHidPhase.WindingUp || prevPhase == MicroHidPhase.WoundUpSustain;
			bool num2 = num & flag;
			float currentPhaseElapsed = _cycle.CurrentPhaseElapsed;
			if (num2)
			{
				ParticleSystem[] startFiringParticles = _startFiringParticles;
				for (int i = 0; i < startFiringParticles.Length; i++)
				{
					startFiringParticles[i].Play(withChildren: false);
				}
			}
			prevPhase = _cycle.Phase;
			float num3;
			if (prevPhase != MicroHidPhase.WindingDown)
			{
				if (prevPhase != MicroHidPhase.Firing)
				{
					goto IL_00a7;
				}
				num3 = Mathf.Clamp01(currentPhaseElapsed / _arcGrowTime);
			}
			else
			{
				if (!WasFiring)
				{
					goto IL_00a7;
				}
				num3 = Mathf.Clamp01(1f - currentPhaseElapsed / _arcGrowTime);
			}
			goto IL_00ad;
			IL_00a7:
			num3 = 0f;
			goto IL_00ad;
			IL_00ad:
			AimedLaser[] lasers;
			if (num3 == 0f || !_cycle.TryGetLastFiringController(out var ret))
			{
				_chargeFireExtras.SetActive(value: false);
				lasers = _lasers;
				foreach (AimedLaser aimedLaser in lasers)
				{
					aimedLaser.SetActive(b: false);
				}
				return;
			}
			_chargeFireExtras.SetActive(ret is ChargeFireModeModule);
			_chargeFireExtras.transform.localScale = Vector3.up * num3;
			lasers = _lasers;
			for (int i = 0; i < lasers.Length; i++)
			{
				AimedLaser aimedLaser2 = lasers[i];
				aimedLaser2.SetActive(b: true);
				aimedLaser2.Update(this, ret, num3);
			}
		}

		private void UpdateBroken()
		{
			if (_wasBroken || !BrokenSyncModule.TryGetBrokenElapsed(_serial, out var elapsed))
			{
				return;
			}
			if (elapsed < 5f)
			{
				_breakParticles.Simulate(elapsed, withChildren: true, restart: true);
				if (_breakParticles.isPaused)
				{
					_breakParticles.Play();
				}
			}
			_wasBroken = true;
		}
	}
}
