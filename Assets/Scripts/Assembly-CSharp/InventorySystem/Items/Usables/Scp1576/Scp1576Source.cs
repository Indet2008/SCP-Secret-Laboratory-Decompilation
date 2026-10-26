using System;
using System.Collections.Generic;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp1576
{
	public class Scp1576Source : MonoBehaviour
	{
		public static Action<Scp1576Source> OnRemoved;

		public static HashSet<Scp1576Source> Instances = new HashSet<Scp1576Source>();

		private Transform _cachedTransform;

		private bool _transformCacheSet;

		private bool _positionUpToDate;

		private Vector3 _lastPos;

		public Vector3 Position
		{
			get
			{
				if (!_positionUpToDate)
				{
					_lastPos = CachedTransform.position;
					_positionUpToDate = true;
				}
				return _lastPos;
			}
		}

		[field: SerializeField]
		public bool HideGlobalIndicator { get; private set; }

		private Transform CachedTransform
		{
			get
			{
				if (!_transformCacheSet)
				{
					_cachedTransform = base.transform;
					_transformCacheSet = true;
				}
				return _cachedTransform;
			}
		}

		private void Update()
		{
			_positionUpToDate = false;
		}

		private void OnEnable()
		{
			Instances.Add(this);
		}

		private void OnDisable()
		{
			OnRemoved?.Invoke(this);
			Instances.Remove(this);
		}

		public override int GetHashCode()
		{
			return base.gameObject.GetHashCode();
		}
	}
}
