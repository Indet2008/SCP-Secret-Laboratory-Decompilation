using System;
using System.Collections.Generic;
using MapGeneration;
using PlayerRoles.PlayableScps.Scp079.GUI;
using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.PlayableScps.Scp079.Map
{
	public class ZoneBlackoutIcon : Scp079GuiElementBase
	{
		private static readonly HashSet<ZoneBlackoutIcon> Instances = new HashSet<ZoneBlackoutIcon>();

		[SerializeField]
		private RectTransform _root;

		[SerializeField]
		private float _triggerDis;

		[SerializeField]
		private FacilityZone _zone;

		[SerializeField]
		private Graphic _recolorable;

		[SerializeField]
		private Color _defaultColor;

		private RectTransform _rt;

		private Scp079TierManager _tier;

		private Scp079BlackoutZoneAbility _ability;

		public static FacilityZone HighlightedZone
		{
			get
			{
				foreach (ZoneBlackoutIcon instance in Instances)
				{
					if (instance.Highlighted)
					{
						return instance._zone;
					}
				}
				return FacilityZone.None;
			}
		}

		private bool Highlighted
		{
			get
			{
				bool flag = Vector3.Distance(_rt.position, _root.position) < _triggerDis * _root.localScale.x;
				_recolorable.color = (flag ? Color.white : _defaultColor);
				return flag;
			}
		}

		internal override void Init(Scp079Role role, ReferenceHub owner)
		{
			base.Init(role, owner);
			base.Role.SubroutineModule.TryGetSubroutine<Scp079TierManager>(out _tier);
			base.Role.SubroutineModule.TryGetSubroutine<Scp079BlackoutZoneAbility>(out _ability);
			Scp079TierManager tier = _tier;
			tier.OnLevelledUp = (Action)Delegate.Combine(tier.OnLevelledUp, new Action(RefreshVisibiltiy));
			Instances.Add(this);
			_rt = GetComponent<RectTransform>();
			RefreshVisibiltiy();
		}

		private void OnDestroy()
		{
			Instances.Remove(this);
			Scp079TierManager tier = _tier;
			tier.OnLevelledUp = (Action)Delegate.Remove(tier.OnLevelledUp, new Action(RefreshVisibiltiy));
		}

		private void RefreshVisibiltiy()
		{
			base.gameObject.SetActive(_ability.Unlocked);
		}
	}
}
