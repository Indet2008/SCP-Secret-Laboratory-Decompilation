using System;
using LabApi.Events.Arguments.Scp106Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp106
{
	public abstract class Scp106VigorAbilityBase : KeySubroutine<Scp106Role>
	{
		private VigorStat _vigor;

		private bool _vigorSet;

		public virtual bool ServerWantsSubmerged => false;

		public virtual float EmergeTime => 1f;

		public virtual float SubmergeTime => 3.1f;

		protected float VigorAmount
		{
			get
			{
				return Vigor.CurValue;
			}
			set
			{
				if (!NetworkServer.active)
				{
					throw new InvalidOperationException("Attempting to set Vigor amount as client.");
				}
				Scp106ChangingVigorEventArgs e = new Scp106ChangingVigorEventArgs(base.Owner, Vigor.CurValue, value);
				Scp106Events.OnChangingVigor(e);
				if (e.IsAllowed)
				{
					value = e.Value;
					Vigor.CurValue = Mathf.Clamp01(value);
					Scp106Events.OnChangedVigor(new Scp106ChangedVigorEventArgs(base.Owner, e.OldValue, value));
				}
			}
		}

		private VigorStat Vigor
		{
			get
			{
				if (_vigorSet)
				{
					return _vigor;
				}
				if (!base.Role.TryGetOwner(out var hub))
				{
					throw new InvalidOperationException("Attempting to access Vigor of inactive SCP-106.");
				}
				if (!hub.playerStats.TryGetModule<VigorStat>(out var module))
				{
					throw new InvalidOperationException("Vigor stat is not defined.");
				}
				_vigor = module;
				_vigorSet = true;
				return module;
			}
		}

		public override void ResetObject()
		{
			_vigorSet = false;
		}
	}
}
