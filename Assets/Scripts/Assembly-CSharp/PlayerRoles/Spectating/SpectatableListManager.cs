using System;
using System.Collections.Generic;
using GameObjectPools;
using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.Spectating
{
	public class SpectatableListManager : MonoBehaviour
	{
		private const int FactionPriorityShift = 24;

		private const int TeamPriorityShift = 16;

		private static KeyCode _nextKey;

		private static KeyCode _prevKey;

		private static readonly Dictionary<SpectatableListElementType, SpectatableListElementDefinition> Definitions = new Dictionary<SpectatableListElementType, SpectatableListElementDefinition>();

		[SerializeField]
		private SpectatableListElementDefinition[] _definedPairs;

		[SerializeField]
		private float _targetHeight;

		[SerializeField]
		private VerticalLayoutGroup _layoutGroup;

		private int _lastTargetId;

		private readonly List<SpectatableListSpawnedElement> _spawnedTargets = new List<SpectatableListSpawnedElement>();

		private ReferenceHub _localHub;

		private bool _anySpectatorSelected;

		public static bool Initialized { get; private set; }

		public static SpectatableListManager Instance { get; private set; }

		private int SpectatablePlayersCount => Mathf.Max(_spawnedTargets.Count - SpectatableVisibilityManager.HiddenPlayersCount, 0);

		private static void RefreshKeybinds()
		{
			_nextKey = NewInput.GetKey(ActionName.Shoot);
			_prevKey = NewInput.GetKey(ActionName.Zoom);
		}

		private static int GetOrderPriority(PlayerRoleBase prb)
		{
			uint num = (uint)prb.Team.GetFaction() << 24;
			int num2 = (int)((uint)prb.Team << 16);
			int roleTypeId = (int)prb.RoleTypeId;
			return (int)(num | (uint)num2) | roleTypeId;
		}

		private static void SetupNewTarget(SpectatableListElementBase element, SpectatableModuleBase module, int order)
		{
			Transform obj = element.transform;
			obj.localScale = Vector3.one;
			obj.SetLocalPositionAndRotation(Vector3.zero, Quaternion.identity);
			obj.SetSiblingIndex(order);
			element.Index = order;
			element.Target = module;
		}

		public void NextTarget(bool forward = true)
		{
			int nextId;
			if (!_anySpectatorSelected)
			{
				if (TryHandleIdOverflow(_lastTargetId + ((!forward) ? (-1) : 0), out var handledId, forward))
				{
					_anySpectatorSelected = true;
					SetTargetId(handledId);
				}
			}
			else if (TryGetNextTargetId(!forward, forward, out nextId))
			{
				SetTargetId(nextId);
			}
		}

		public bool SetTargetId(int newTargetId)
		{
			if (!TryHandleIdOverflow(newTargetId, out var handledId))
			{
				return false;
			}
			_lastTargetId = handledId;
			SpectatorTargetTracker.CurrentTarget = _spawnedTargets[handledId].Target;
			_anySpectatorSelected = true;
			return true;
		}

		public bool TrySetTarget(ReferenceHub hub)
		{
			if (hub == null)
			{
				_lastTargetId = 0;
				SpectatorTargetTracker.CurrentTarget = null;
				_anySpectatorSelected = true;
				return true;
			}
			if (!TryGetTargetId(hub, out var targetId))
			{
				return false;
			}
			return SetTargetId(targetId);
		}

		public bool TryGetTargetId(ReferenceHub hub, out int targetId)
		{
			for (int i = 0; i < _spawnedTargets.Count; i++)
			{
				if (!(_spawnedTargets[i].Target.TargetHub != hub))
				{
					targetId = i;
					return true;
				}
			}
			targetId = 0;
			return false;
		}

		public bool TryGetCurrentlySpectatedHub(out ReferenceHub hub)
		{
			for (int i = 0; i < _spawnedTargets.Count; i++)
			{
				if (i == _lastTargetId)
				{
					hub = _spawnedTargets[i].Target.TargetHub;
					return true;
				}
			}
			hub = null;
			return false;
		}

		private void OnEnable()
		{
			SpectatorTargetTracker.OnTargetChanged += RefreshSize;
			SpectatableModuleBase.OnAdded += AddTarget;
			SpectatableModuleBase.OnRemoved += RemoveTarget;
			SpectatableVisibilityManager.OnVisibilityChanged = (Action<ReferenceHub, bool>)Delegate.Combine(SpectatableVisibilityManager.OnVisibilityChanged, new Action<ReferenceHub, bool>(OnVisibilityChanged));
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
			if (!Initialized)
			{
				SpectatableListElementDefinition[] definedPairs = _definedPairs;
				for (int i = 0; i < definedPairs.Length; i++)
				{
					SpectatableListElementDefinition value = definedPairs[i];
					Definitions[value.Type] = value;
					PoolManager.Singleton.TryAddPool(value.FullSize);
					PoolManager.Singleton.TryAddPool(value.Compact);
				}
				RefreshKeybinds();
				Initialized = true;
				Instance = this;
			}
			RefreshAllTargets();
			ReferenceHub.TryGetLocalHub(out _localHub);
			_anySpectatorSelected = false;
			_lastTargetId = 0;
		}

		private void OnDisable()
		{
			SpectatorTargetTracker.OnTargetChanged -= RefreshSize;
			SpectatableModuleBase.OnAdded -= AddTarget;
			SpectatableModuleBase.OnRemoved -= RemoveTarget;
			SpectatableVisibilityManager.OnVisibilityChanged = (Action<ReferenceHub, bool>)Delegate.Remove(SpectatableVisibilityManager.OnVisibilityChanged, new Action<ReferenceHub, bool>(OnVisibilityChanged));
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
		}

		private void LateUpdate()
		{
			bool keyDown = Input.GetKeyDown(_prevKey);
			bool keyDown2 = Input.GetKeyDown(_nextKey);
			if ((keyDown || keyDown2) && TryGetNextTargetId(keyDown, keyDown2, out var nextId) && nextId != _lastTargetId && !ToggleableMenus.ToggleableMenuController.AnyEnabled && !SpectatorGuiElement.AnyHighlighted)
			{
				if (_anySpectatorSelected)
				{
					_lastTargetId = nextId;
					SetTargetId(nextId);
				}
				else
				{
					NextTarget(keyDown2);
					_anySpectatorSelected = true;
				}
			}
		}

		private bool TryGetNextTargetId(bool prevKeyDown, bool nextKeyDown, out int nextId)
		{
			return TryHandleIdOverflow(_lastTargetId + (nextKeyDown ? 1 : 0) - (prevKeyDown ? 1 : 0), out nextId, nextKeyDown);
		}

		private bool TryHandleIdOverflow(int newTargetId, out int handledId, bool moveForward = true)
		{
			if (SpectatablePlayersCount == 0)
			{
				handledId = 0;
				return false;
			}
			newTargetId = OverflowIndex(newTargetId);
			while (_localHub.roleManager.CurrentRole.RoleTypeId != RoleTypeId.Overwatch && SpectatableVisibilityManager.IsHidden(_spawnedTargets[newTargetId].Target.TargetHub))
			{
				newTargetId += (moveForward ? 1 : (-1));
				newTargetId = OverflowIndex(newTargetId);
			}
			handledId = newTargetId;
			return true;
		}

		private int OverflowIndex(int index)
		{
			if (index < 0)
			{
				return _spawnedTargets.Count - 1;
			}
			if (index >= _spawnedTargets.Count)
			{
				return 0;
			}
			return index;
		}

		private void AddTarget(SpectatableModuleBase target)
		{
			int orderPriority = GetOrderPriority(target.MainRole);
			int num = _spawnedTargets.Count;
			for (int i = 0; i < _spawnedTargets.Count; i++)
			{
				if (_spawnedTargets[i].Priority > orderPriority)
				{
					num = i;
					break;
				}
			}
			if (Definitions.TryGetValue(target.ListElementType, out var value) && value.TryGetFromPools(base.transform, out var full, out var compact))
			{
				SpectatableListSpawnedElement item = new SpectatableListSpawnedElement
				{
					Priority = orderPriority,
					Compact = compact,
					FullSize = full,
					Target = target
				};
				SetupNewTarget(item.Compact, target, num * 2);
				SetupNewTarget(item.FullSize, target, num * 2 + 1);
				_spawnedTargets.Insert(num, item);
				RefreshSize();
			}
		}

		private void RemoveTarget(SpectatableModuleBase target)
		{
			for (int i = 0; i < _spawnedTargets.Count; i++)
			{
				if (!(_spawnedTargets[i].Compact.Target != target))
				{
					if (_lastTargetId == i)
					{
						_anySpectatorSelected = false;
					}
					_spawnedTargets[i].ReturnToPool();
					_spawnedTargets.RemoveAt(i);
					break;
				}
			}
			RefreshSize();
		}

		private void RefreshAllTargets()
		{
			_spawnedTargets.ForEach((SpectatableListSpawnedElement x) =>
			{
				x.ReturnToPool();
			});
			_spawnedTargets.Clear();
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is ISpectatableRole spectatableRole)
				{
					AddTarget(spectatableRole.SpectatorModule);
				}
			}
		}

		private void RefreshSize()
		{
			int count = _spawnedTargets.Count;
			if (count == 0)
			{
				return;
			}
			float num2;
			float num = (num2 = _layoutGroup.spacing * (float)(count - 1));
			for (int i = 0; i < count; i++)
			{
				SpectatableListSpawnedElement spectatableListSpawnedElement = _spawnedTargets[i];
				num2 += spectatableListSpawnedElement.Compact.Height;
				num += spectatableListSpawnedElement.FullSize.Height;
				if (_spawnedTargets[i].Target == SpectatorTargetTracker.CurrentTarget)
				{
					_lastTargetId = i;
				}
			}
			float num3 = Mathf.InverseLerp(num2, num, _targetHeight);
			int num6;
			int num7;
			if (num3 < 1f)
			{
				int num4 = Mathf.FloorToInt(num3 * (float)count) - 1;
				if (num4 > 12)
				{
					num4 = 12;
				}
				else if (num4 % 2 != 0)
				{
					num4--;
				}
				int num5 = Mathf.Clamp(_lastTargetId, 0, count - 1);
				num6 = num5 - num4 / 2;
				num7 = num5 + num4 / 2;
				if (num6 < 0)
				{
					num7 -= num6;
				}
				if (num7 >= count)
				{
					num6 += 1 + count - num7;
				}
			}
			else
			{
				num6 = 0;
				num7 = count;
			}
			for (int j = 0; j < count; j++)
			{
				bool flag = j >= num6 && j <= num7;
				SpectatableListSpawnedElement spectatableListSpawnedElement2 = _spawnedTargets[j];
				bool num8 = SpectatableVisibilityManager.IsHidden(spectatableListSpawnedElement2.Target.TargetHub);
				bool flag2 = _localHub != null && _localHub.roleManager.CurrentRole.RoleTypeId == RoleTypeId.Overwatch;
				bool flag3 = !num8 | flag2;
				spectatableListSpawnedElement2.FullSize.gameObject.SetActive(flag & flag3);
				spectatableListSpawnedElement2.Compact.gameObject.SetActive(!flag & flag3);
			}
		}

		private void OnVisibilityChanged(ReferenceHub hub, bool forceHidden)
		{
			RefreshSize();
			if (SpectatablePlayersCount == 0)
			{
				SpectatorTargetTracker.CurrentTarget = null;
			}
			else if (forceHidden)
			{
				int index = Mathf.Clamp(_lastTargetId, 0, _spawnedTargets.Count - 1);
				if (!(_spawnedTargets[index].Target.TargetHub != hub) && _localHub.roleManager.CurrentRole.RoleTypeId != RoleTypeId.Overwatch)
				{
					NextTarget();
				}
			}
		}

		private void OnRoleChanged(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (!(_localHub == null) && !(userHub != _localHub) && newRole is SpectatorRole)
			{
				RefreshAllTargets();
				TrySetTarget(null);
				_anySpectatorSelected = false;
			}
		}
	}
}
