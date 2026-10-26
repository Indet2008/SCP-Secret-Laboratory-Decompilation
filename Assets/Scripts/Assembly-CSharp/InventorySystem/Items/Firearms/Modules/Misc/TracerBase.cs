using System;
using System.Collections.Generic;
using InventorySystem.Items.Firearms.Extensions;
using Mirror;
using RelativePositioning;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	public abstract class TracerBase : MonoBehaviour
	{
		private Queue<TracerBase> _instancesPool;

		private bool _isInstance;

		private Vector3? _origin;

		private Vector3 _fallbackOrigin;

		public Vector3 OriginPosition
		{
			get
			{
				if (_origin.HasValue)
				{
					return _origin.Value;
				}
				if (BarrelTipExtension.TryFindWorldmodelBarrelTip(Serial, out var foundExtension))
				{
					_origin = foundExtension.WorldspacePosition;
				}
				else
				{
					_origin = _fallbackOrigin;
				}
				return _origin.Value;
			}
		}

		public RelativePosition RelativeHitPosition { get; private set; }

		public ushort Serial { get; private set; }

		public Firearm Template { get; private set; }

		protected abstract bool IsBusy { get; }

		protected virtual void OnCreated()
		{
		}

		protected virtual void OnDequeued()
		{
		}

		protected abstract void OnFired(NetworkReader extraData);

		public virtual void ServerWriteExtraData(Firearm firearm, NetworkWriter writer)
		{
		}

		public void Fire(RelativePosition hitPosition, ushort serial, Vector3 fallbackOriginPosition, NetworkReader extraData, Firearm template)
		{
			if (!_isInstance)
			{
				throw new InvalidOperationException("Attempting to fire a template or non-pooled tracer. Please get an instance using the GetFromPool method.");
			}
			RelativeHitPosition = hitPosition;
			Serial = serial;
			Template = template;
			_origin = null;
			_fallbackOrigin = fallbackOriginPosition;
			OnFired(extraData);
		}

		public TracerBase GetFromPool()
		{
			if (_isInstance)
			{
				throw new InvalidOperationException("GetFromPool can only be called on the prefab tracer object.");
			}
			if (_instancesPool == null)
			{
				_instancesPool = new Queue<TracerBase>();
			}
			TracerBase result;
			while (_instancesPool.TryPeek(out result))
			{
				if (result == null)
				{
					_instancesPool.Dequeue();
					continue;
				}
				if (result.IsBusy)
				{
					break;
				}
				TracerBase tracerBase = _instancesPool.Dequeue();
				tracerBase.OnDequeued();
				_instancesPool.Enqueue(tracerBase);
				return tracerBase;
			}
			TracerBase tracerBase2 = UnityEngine.Object.Instantiate(this);
			_instancesPool.Enqueue(tracerBase2);
			tracerBase2._isInstance = true;
			tracerBase2.OnCreated();
			return tracerBase2;
		}
	}
}
