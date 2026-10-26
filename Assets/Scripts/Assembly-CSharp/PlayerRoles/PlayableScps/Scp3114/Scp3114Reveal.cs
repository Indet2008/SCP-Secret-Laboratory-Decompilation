using System;
using LabApi.Events.Arguments.Scp3114Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114Reveal : KeySubroutine<Scp3114Role>
	{
		private const float HoldDuration = 0.65f;

		public const ActionName RevealKey = ActionName.Reload;

		private float _holdTimer;

		protected override ActionName TargetKey => ActionName.Reload;

		protected override bool KeyPressable
		{
			get
			{
				if (base.KeyPressable && base.CastRole.Disguised)
				{
					return _holdTimer < 0.65f;
				}
				return false;
			}
		}

		public static event Action OnRevealFail;

		protected override void Update()
		{
			base.Update();
			if (base.Role.IsLocalPlayer)
			{
				if (IsKeyHeld && base.CastRole.Disguised)
				{
					_holdTimer += Time.deltaTime;
				}
				else
				{
					_holdTimer = 0f;
				}
			}
		}

		protected override void OnKeyUp()
		{
			base.OnKeyUp();
			if (base.CastRole.Disguised)
			{
				if (_holdTimer >= 0.65f)
				{
					ClientSendCmd();
				}
				else
				{
					OnRevealFail?.Invoke();
				}
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			Scp3114RevealingEventArgs e = new Scp3114RevealingEventArgs(base.Owner, forced: false);
			Scp3114Events.OnRevealing(e);
			if (e.IsAllowed)
			{
				base.CastRole.Disguised = false;
				Scp3114Events.OnRevealed(new Scp3114RevealedEventArgs(base.Owner, forced: false));
			}
		}
	}
}
