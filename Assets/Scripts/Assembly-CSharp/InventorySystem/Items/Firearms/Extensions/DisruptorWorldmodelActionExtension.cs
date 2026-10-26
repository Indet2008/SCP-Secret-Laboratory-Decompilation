using System.Collections.Generic;
using Footprinting;
using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.Firearms.ShotEvents;
using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class DisruptorWorldmodelActionExtension : MonoBehaviour, IWorldmodelExtension, IPickupLockingExtension
	{
		private static readonly int DissolveHash = Shader.PropertyToID("_Dissolve");

		private static readonly Dictionary<Material, Queue<Material>> DissolveMatPool = new Dictionary<Material, Queue<Material>>();

		private static readonly List<Material> MatsNonAlloc = new List<Material>();

		private FirearmWorldmodel _worldmodel;

		private float[] _scheduledRemainingShotTimes;

		private Footprint _scheduledAttackerFootprint;

		private DisruptorActionModule.FiringState _scheduledFiringState;

		private Rigidbody _rigidbody;

		private float _breakingProgress;

		private bool _isWorldmodel;

		private Dictionary<Material, Material> _materialInstances;

		[SerializeField]
		private float _singleShotForce;

		[SerializeField]
		private float _rapidFireForce;

		[SerializeField]
		private float _torqueMultiplier;

		[SerializeField]
		private float _breakingSpeed;

		[SerializeField]
		private float _breakingDestroyThreshold;

		[SerializeField]
		private MeshRenderer[] _renderers;

		private bool Breaking => ParticleDisruptor.BrokenSerials.Contains(_worldmodel.Identifier.SerialNumber);

		public bool LockPrefab
		{
			get
			{
				if (_scheduledRemainingShotTimes == null)
				{
					return Breaking;
				}
				return true;
			}
		}

		private void Update()
		{
			if (NetworkServer.active)
			{
				ServerUpdateShots();
			}
			if (_worldmodel.WorldmodelType == FirearmWorldmodelType.Pickup && Breaking)
			{
				UpdateBreaking();
			}
		}

		private void Start()
		{
			_rigidbody = GetComponentInParent<Rigidbody>();
		}

		private void OnDestroy()
		{
			if (_materialInstances == null)
			{
				return;
			}
			foreach (KeyValuePair<Material, Material> materialInstance in _materialInstances)
			{
				DissolveMatPool.GetOrAdd(materialInstance.Key, () => new Queue<Material>()).Enqueue(materialInstance.Value);
			}
		}

		private Material DuplicateMaterial(Material shared)
		{
			if (DissolveMatPool.TryGetValue(shared, out var value))
			{
				return value.Dequeue();
			}
			return new Material(shared);
		}

		private void ReplaceMaterials(MeshRenderer rend)
		{
			MatsNonAlloc.Clear();
			rend.GetSharedMaterials(MatsNonAlloc);
			int count = MatsNonAlloc.Count;
			Material[] array = new Material[count];
			for (int i = 0; i < count; i++)
			{
				Material shared = MatsNonAlloc[i];
				array[i] = _materialInstances.GetOrAdd(shared, () => DuplicateMaterial(shared));
			}
			rend.sharedMaterials = array;
		}

		private void UpdateBreaking()
		{
			if (_materialInstances == null)
			{
				_materialInstances = new Dictionary<Material, Material>();
				_renderers.ForEach(ReplaceMaterials);
			}
			_breakingProgress += Time.deltaTime * _breakingSpeed;
			foreach (KeyValuePair<Material, Material> materialInstance in _materialInstances)
			{
				materialInstance.Value.SetFloat(DissolveHash, _breakingProgress);
			}
			if (_breakingProgress > _breakingDestroyThreshold && NetworkServer.active)
			{
				ItemPickupBase componentInParent = GetComponentInParent<ItemPickupBase>();
				if (componentInParent != null)
				{
					componentInParent.DestroySelf();
				}
				else
				{
					base.enabled = false;
				}
			}
		}

		private void ServerUpdateShots()
		{
			if (_scheduledRemainingShotTimes == null)
			{
				return;
			}
			bool flag = false;
			for (int i = 0; i < _scheduledRemainingShotTimes.Length; i++)
			{
				float num = _scheduledRemainingShotTimes[i];
				if (!(num < 0f))
				{
					num -= Time.deltaTime;
					if (num > 0f)
					{
						flag = true;
					}
					else
					{
						ServerFire();
					}
					_scheduledRemainingShotTimes[i] = num;
				}
			}
			if (!flag)
			{
				_scheduledRemainingShotTimes = null;
				ItemIdentifier identifier = _worldmodel.Identifier;
				ParticleDisruptor template = identifier.TypeId.GetTemplate<ParticleDisruptor>();
				if (template.TryGetModule<MagazineModule>(out var module) && module.GetAmmoStoredForSerial(identifier.SerialNumber) <= 0)
				{
					template.ServerSendBrokenRpc(identifier.SerialNumber);
				}
			}
		}

		private void ServerFire()
		{
			if (_worldmodel.TryGetExtension<BarrelTipExtension>(out var extension))
			{
				DisruptorHitregModule.TemplateSimulateShot(new DisruptorShotEvent(_worldmodel.Identifier, _scheduledAttackerFootprint, _scheduledFiringState), extension);
				if (_rigidbody != null)
				{
					float num = ((_scheduledFiringState == DisruptorActionModule.FiringState.FiringSingle) ? _singleShotForce : _rapidFireForce);
					_rigidbody.AddForceAtPosition(-extension.WorldspaceDirection * num, extension.WorldspacePosition, ForceMode.Impulse);
					_rigidbody.AddRelativeTorque(_torqueMultiplier * num * Vector3.right, ForceMode.Impulse);
				}
			}
		}

		public void SetupWorldmodel(FirearmWorldmodel worldmodel)
		{
			_worldmodel = worldmodel;
		}

		public void ServerScheduleShot(Footprint attackerFootprint, DisruptorActionModule.FiringState firingState, float[] remainingShots)
		{
			_scheduledAttackerFootprint = attackerFootprint;
			_scheduledFiringState = firingState;
			_scheduledRemainingShotTimes = remainingShots;
		}
	}
}
