using System;
using System.Collections.Generic;
using GameObjectPools;
using UnityEngine;

namespace PlayerRoles.Spectating
{
	public abstract class SpectatableModuleBase : MonoBehaviour, IPoolSpawnable, IPoolResettable
	{
		public delegate void Added(SpectatableModuleBase module);

		public delegate void Removed(SpectatableModuleBase module);

		public static readonly HashSet<SpectatableModuleBase> AllInstances = new HashSet<SpectatableModuleBase>();

		public SpectatableListElementType ListElementType;

		private PlayerRoleBase _cachedRole;

		private bool _roleCacheSet;

		public abstract Vector3 CameraPosition { get; }

		public abstract Vector3 CameraRotation { get; }

		public PlayerRoleBase MainRole
		{
			get
			{
				if (!_roleCacheSet)
				{
					if (!TryGetComponent<PlayerRoleBase>(out _cachedRole))
					{
						throw new InvalidOperationException("SpectatableModuleBase of name '" + base.name + "' is not assigned to any role!");
					}
					_roleCacheSet = true;
				}
				return _cachedRole;
			}
		}

		public ReferenceHub TargetHub
		{
			get
			{
				MainRole.TryGetOwner(out var hub);
				if (hub == null)
				{
					throw new InvalidOperationException("SpectatableModuleBase of name '" + base.name + "' does not have an owner!");
				}
				return hub;
			}
		}

		public bool IsSpectatingAllowed
		{
			get
			{
				if (TargetHub == null)
				{
					return false;
				}
				return !SpectatableVisibilityManager.IsHidden(TargetHub);
			}
			set
			{
				if (!(TargetHub == null))
				{
					SpectatableVisibilityManager.SetHidden(TargetHub, !value);
				}
			}
		}

		public static event Added OnAdded;

		public static event Removed OnRemoved;

		public virtual void ResetObject()
		{
			AllInstances.Remove(this);
			OnRemoved?.Invoke(this);
		}

		public virtual void SpawnObject()
		{
			AllInstances.Add(this);
			OnAdded?.Invoke(this);
		}

		internal virtual void OnBeganSpectating()
		{
		}

		internal virtual void OnStoppedSpectating()
		{
		}
	}
}
