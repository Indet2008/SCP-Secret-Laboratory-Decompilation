using System.Collections.Generic;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

namespace WaterPhysics
{
	public class BuoyantWater : MonoBehaviour
	{
		private struct TrackedRigidbody
		{
			public Rigidbody Rigidbody;

			public BuoyancyMode Mode;

			public double EnterTime;
		}

		private static readonly Dictionary<ItemCategory, BuoyancyMode> BuoyancyByPickupCategory = new Dictionary<ItemCategory, BuoyancyMode>
		{
			[ItemCategory.Ammo] = BuoyancyMode.ShortTimeFloaters,
			[ItemCategory.Armor] = BuoyancyMode.ShortTimeFloaters,
			[ItemCategory.Firearm] = BuoyancyMode.NonBuoyant,
			[ItemCategory.Grenade] = BuoyancyMode.NonBuoyant,
			[ItemCategory.Radio] = BuoyancyMode.NonBuoyant,
			[ItemCategory.SpecialWeapon] = BuoyancyMode.SuperHeavy
		};

		private const BuoyancyMode DefaultBuoyancyPickup = BuoyancyMode.Floater;

		private const BuoyancyMode DefaultBuoyancyOther = BuoyancyMode.LongTimeFloaters;

		[SerializeField]
		private float _startHeight;

		[SerializeField]
		private float _fullSubmergeWeight;

		[SerializeField]
		private Vector3 _localFlowDirection;

		[SerializeField]
		private AnimationCurve _forceOverDot;

		private bool _trCacheSet;

		private Transform _cachedTransform;

		private readonly List<TrackedRigidbody> _tracked = new List<TrackedRigidbody>();

		private Transform FastTr
		{
			get
			{
				if (!_trCacheSet)
				{
					_trCacheSet = true;
					_cachedTransform = base.transform;
				}
				return _cachedTransform;
			}
		}

		private Vector3 FlowDirection => FastTr.rotation * _localFlowDirection;

		private void FixedUpdate()
		{
			for (int num = _tracked.Count - 1; num >= 0; num--)
			{
				TrackedRigidbody trackedRigidbody = _tracked[num];
				if (trackedRigidbody.Rigidbody == null)
				{
					_tracked.RemoveAt(num);
				}
				else
				{
					double num2 = NetworkTime.time - trackedRigidbody.EnterTime;
					Vector3 position = trackedRigidbody.Rigidbody.position;
					Vector3 flow = EvaluateFlowForceAtPoint(position) * FlowDirection;
					float value = position.y - FastTr.position.y;
					float submergeRatio = Mathf.InverseLerp(_startHeight, _fullSubmergeWeight, value);
					BuoyancyProcessor.ProcessFixedUpdate(trackedRigidbody.Rigidbody, trackedRigidbody.Mode, (float)num2, submergeRatio, flow);
				}
			}
		}

		private void OnTriggerEnter(Collider other)
		{
			Rigidbody attachedRigidbody = other.attachedRigidbody;
			if (attachedRigidbody == null)
			{
				return;
			}
			for (int i = 0; i < _tracked.Count; i++)
			{
				if (!(_tracked[i].Rigidbody != attachedRigidbody))
				{
					return;
				}
			}
			BuoyancyMode modeForRigidbody = GetModeForRigidbody(attachedRigidbody);
			_tracked.Add(new TrackedRigidbody
			{
				EnterTime = NetworkTime.time,
				Mode = modeForRigidbody,
				Rigidbody = attachedRigidbody
			});
			BuoyancyProcessor.ProcessNew(attachedRigidbody, modeForRigidbody);
		}

		private void OnTriggerExit(Collider other)
		{
			Rigidbody attachedRigidbody = other.attachedRigidbody;
			if (attachedRigidbody == null)
			{
				return;
			}
			for (int num = _tracked.Count - 1; num >= 0; num--)
			{
				TrackedRigidbody trackedRigidbody = _tracked[num];
				if (!(trackedRigidbody.Rigidbody != attachedRigidbody))
				{
					BuoyancyProcessor.ProcessExit(trackedRigidbody.Rigidbody);
					_tracked.RemoveAt(num);
					break;
				}
			}
		}

		private void OnDrawGizmosSelected()
		{
			Gizmos.color = Color.green;
			Vector3 position = FastTr.position;
			Gizmos.DrawLine(position + Vector3.up * _fullSubmergeWeight, position + Vector3.up * _startHeight);
			Vector3 flowDirection = FlowDirection;
			for (int i = 0; i < _forceOverDot.length; i++)
			{
				Keyframe keyframe = _forceOverDot[i];
				Gizmos.DrawSphere(position + flowDirection * keyframe.time, keyframe.value / 5f + 0.05f);
			}
		}

		private BuoyancyMode GetModeForRigidbody(Rigidbody rb)
		{
			if (rb.TryGetComponent<BuoyancyDefinition>(out var component))
			{
				return component.Mode;
			}
			if (!rb.TryGetComponent<ItemPickupBase>(out var component2))
			{
				return BuoyancyMode.LongTimeFloaters;
			}
			if (!component2.Info.ItemId.TryGetTemplate<ItemBase>(out var item))
			{
				return BuoyancyMode.Floater;
			}
			if (!BuoyancyByPickupCategory.TryGetValue(item.Category, out var value))
			{
				return BuoyancyMode.Floater;
			}
			return value;
		}

		private float EvaluateFlowForceAtPoint(Vector3 point)
		{
			float time = Vector3.Dot(point - FastTr.position, FlowDirection);
			return _forceOverDot.Evaluate(time);
		}
	}
}
