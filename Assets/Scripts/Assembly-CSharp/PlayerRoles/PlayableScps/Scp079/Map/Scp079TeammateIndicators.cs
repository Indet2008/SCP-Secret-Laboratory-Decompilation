using System;
using System.Collections.Generic;
using PlayerRoles.PlayableScps.Scp079.GUI;
using PlayerRoles.Subroutines;
using TMPro;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp079.Map
{
	public class Scp079TeammateIndicators : Scp079GuiElementBase
	{
		private enum IndicatorType
		{
			Low = 0,
			Medium = 1,
			High = 2
		}

		private const float NonExactCooldown = 1.5f;

		private Scp079TierManager _tierManager;

		private IZoneMap[] _maps;

		private readonly AbilityCooldown _nonExactCooldown = new AbilityCooldown();

		private readonly Dictionary<ReferenceHub, RectTransform> _instances = new Dictionary<ReferenceHub, RectTransform>();

		[SerializeField]
		private RectTransform _templateLow;

		[SerializeField]
		private RectTransform _templateMid;

		[SerializeField]
		private RectTransform _templateHigh;

		private IndicatorType CurType
		{
			get
			{
				int accessTierLevel = _tierManager.AccessTierLevel;
				if (accessTierLevel <= 2)
				{
					return IndicatorType.Low;
				}
				if (accessTierLevel == 3)
				{
					return IndicatorType.Medium;
				}
				return IndicatorType.High;
			}
		}

		internal override void Init(Scp079Role role, ReferenceHub owner)
		{
			base.Init(role, owner);
			role.SubroutineModule.TryGetSubroutine<Scp079TierManager>(out _tierManager);
			Scp079TierManager tierManager = _tierManager;
			tierManager.OnLevelledUp = (Action)Delegate.Combine(tierManager.OnLevelledUp, new Action(Rebuild));
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
			ReferenceHub.OnPlayerRemoved += OnPlayerRemoved;
			_maps = GetComponentsInChildren<IZoneMap>(includeInactive: true);
			Rebuild();
		}

		private void OnDestroy()
		{
			Scp079TierManager tierManager = _tierManager;
			tierManager.OnLevelledUp = (Action)Delegate.Remove(tierManager.OnLevelledUp, new Action(Rebuild));
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
			ReferenceHub.OnPlayerRemoved -= OnPlayerRemoved;
		}

		private void OnRoleChanged(ReferenceHub hub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			RefreshPlayerIndicator(hub);
		}

		private void OnPlayerRemoved(ReferenceHub hub)
		{
			RemovePlayerIndicator(hub);
		}

		private void RemovePlayerIndicator(ReferenceHub hub)
		{
			if (_instances.Remove(hub, out var value))
			{
				UnityEngine.Object.Destroy(value.gameObject);
			}
		}

		private void RefreshPlayerIndicator(ReferenceHub hub)
		{
			RemovePlayerIndicator(hub);
			SetupPlayer(hub);
		}

		private void SetupPlayer(ReferenceHub hub)
		{
			if (!hub.IsSCP(includeZombies: false))
			{
				return;
			}
			RectTransform rectTransform;
			switch (CurType)
			{
			default:
				return;
			case IndicatorType.Low:
				rectTransform = UnityEngine.Object.Instantiate(_templateLow);
				break;
			case IndicatorType.Medium:
				rectTransform = UnityEngine.Object.Instantiate(_templateMid);
				break;
			case IndicatorType.High:
			{
				rectTransform = UnityEngine.Object.Instantiate(_templateHigh);
				string text = hub.roleManager.CurrentRole.RoleTypeId.ToString();
				if (text.Length > 3)
				{
					rectTransform.GetComponentInChildren<TextMeshProUGUI>().text = text.Substring(3);
				}
				break;
			}
			}
			rectTransform.localScale = Vector3.one;
			_instances[hub] = rectTransform;
		}

		private void Rebuild()
		{
			_instances.ForEachValue((RectTransform x) =>
			{
				UnityEngine.Object.Destroy(x.gameObject);
			});
			_instances.Clear();
			ReferenceHub.AllHubs.ForEach(SetupPlayer);
		}

		private void Update()
		{
			if (!Scp079ToggleMenuAbilityBase<Scp079MapToggler>.IsOpen)
			{
				return;
			}
			IndicatorType curType = CurType;
			if (curType == IndicatorType.Low)
			{
				if (!_nonExactCooldown.IsReady)
				{
					return;
				}
				_nonExactCooldown.Trigger(1.5);
			}
			foreach (KeyValuePair<ReferenceHub, RectTransform> instance in _instances)
			{
				bool flag = false;
				IZoneMap[] maps = _maps;
				for (int i = 0; i < maps.Length; i++)
				{
					if (maps[i].TrySetPlayerIndicator(instance.Key, instance.Value, curType != IndicatorType.Low))
					{
						flag = true;
					}
				}
				instance.Value.gameObject.SetActive(flag);
				if (flag && curType == IndicatorType.High)
				{
					instance.Value.GetComponentInChildren<TextMeshProUGUI>().rectTransform.rotation = _templateHigh.rotation;
				}
			}
		}
	}
}
