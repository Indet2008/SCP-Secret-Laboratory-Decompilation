using System;
using GameObjectPools;
using PlayerRoles.Spectating.SpectatableListEffects;
using UnityEngine;

namespace PlayerRoles.Spectating
{
	public class SpectatableListElementBase : PoolObject
	{
		[SerializeField]
		private SpectatorIconEffect[] _iconEffects;

		private RectTransform _cachedTransform;

		private SpectatableModuleBase _target;

		private bool _transformCacheSet;

		protected RectTransform CachedRectTransform
		{
			get
			{
				if (!_transformCacheSet)
				{
					if (!TryGetComponent<RectTransform>(out _cachedTransform))
					{
						throw new InvalidOperationException("SpectatableListElementBase of name '" + base.name + "' does not have a rect transform!");
					}
					_transformCacheSet = true;
				}
				return _cachedTransform;
			}
		}

		public SpectatableModuleBase Target
		{
			get
			{
				return _target;
			}
			internal set
			{
				SpectatableModuleBase target = _target;
				if (value != target)
				{
					_target = value;
					OnTargetChanged(target, value);
				}
			}
		}

		public int Index { get; internal set; }

		public float Height => CachedRectTransform.sizeDelta.y;

		public bool IsCurrent
		{
			get
			{
				if (!base.Pooled)
				{
					return Target == SpectatorTargetTracker.CurrentTarget;
				}
				return false;
			}
		}

		protected virtual void OnTargetChanged(SpectatableModuleBase prevTarget, SpectatableModuleBase newTarget)
		{
			SpectatorIconEffect[] iconEffects = _iconEffects;
			for (int i = 0; i < iconEffects.Length; i++)
			{
				iconEffects[i].OnTargetChanged(prevTarget, newTarget);
			}
		}

		public void BeginSpectating()
		{
			SpectatorTargetTracker.CurrentTarget = Target;
		}

		protected virtual void Update()
		{
			SpectatorIconEffect[] iconEffects = _iconEffects;
			for (int i = 0; i < iconEffects.Length; i++)
			{
				iconEffects[i].Update();
			}
		}

		private void Start()
		{
			SpectatorIconEffect[] iconEffects = _iconEffects;
			foreach (SpectatorIconEffect obj in iconEffects)
			{
				obj.SpectatableListElement = this;
				obj.gameObject.SetActive(value: false);
				obj.IsVisible = false;
				obj.Start();
			}
		}
	}
}
