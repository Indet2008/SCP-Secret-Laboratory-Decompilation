using System;
using System.Collections.Generic;
using LabApi.Events.Arguments.Scp3114Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.PlayableScps.Scp049;
using PlayerRoles.Ragdolls;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114Disguise : RagdollAbilityBase<Scp3114Role>
	{
		public readonly AbilityCooldown Cooldown = new AbilityCooldown();

		private readonly Dictionary<BasicRagdoll, byte> _prevUnitIds = new Dictionary<BasicRagdoll, byte>();

		[SerializeField]
		private AudioSource _equipSkinSound;

		protected override float RangeSqr => 3.5f;

		protected override float Duration => 5f;

		public event Action<Scp3114HudTranslation> OnClientError;

		public override void SpawnObject()
		{
			base.SpawnObject();
			RagdollManager.ServerOnRagdollCreated += ServerOnRagdollCreated;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			Cooldown.Clear();
			RagdollManager.ServerOnRagdollCreated -= ServerOnRagdollCreated;
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			Cooldown.ReadCooldown(reader);
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			Cooldown.WriteCooldown(writer);
		}

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			if (Cooldown.IsReady)
			{
				ClientTryStart();
			}
		}

		protected override void OnKeyUp()
		{
			base.OnKeyUp();
			ClientTryCancel();
		}

		protected override void OnProgressSet()
		{
			base.OnProgressSet();
			Scp3114Identity.StolenIdentity curIdentity = base.CastRole.CurIdentity;
			if (base.IsInProgress)
			{
				_equipSkinSound.Play();
				curIdentity.Ragdoll = base.CurRagdoll;
				curIdentity.UnitNameId = (byte)(_prevUnitIds.TryGetValue(base.CurRagdoll, out var value) ? value : 0);
				curIdentity.Status = Scp3114Identity.DisguiseStatus.Equipping;
			}
			else if (curIdentity.Status == Scp3114Identity.DisguiseStatus.Equipping)
			{
				_equipSkinSound.Stop();
				curIdentity.Status = Scp3114Identity.DisguiseStatus.None;
				if (NetworkServer.active)
				{
					Cooldown.Trigger(Duration);
					ServerSendRpc(toAll: true);
				}
			}
		}

		protected override void ServerComplete()
		{
			if (Cooldown.IsReady)
			{
				base.CastRole.Disguised = true;
				Scp3114Events.OnDisguised(new Scp3114DisguisedEventArgs(base.Owner, base.CurRagdoll));
				if (!(base.CurRagdoll == null) && base.CurRagdoll is DynamicRagdoll ragdoll)
				{
					Scp3114RagdollToBonesConverter.ServerConvertNew(base.CastRole, ragdoll);
				}
			}
		}

		protected override byte ServerValidateBegin(BasicRagdoll ragdoll)
		{
			bool flag = !AnyValidateBegin(ragdoll, out var error);
			if (!flag)
			{
				Scp3114DisguisingEventArgs e = new Scp3114DisguisingEventArgs(base.Owner, ragdoll);
				Scp3114Events.OnDisguising(e);
				if (!e.IsAllowed)
				{
					return 6;
				}
			}
			return (byte)(flag ? error : Scp3114HudTranslation.IdentityStolenWarning);
		}

		protected override bool ClientValidateBegin(BasicRagdoll raycastedRagdoll)
		{
			if (AnyValidateBegin(raycastedRagdoll, out var error))
			{
				return base.ClientValidateBegin(raycastedRagdoll);
			}
			OnClientError(error);
			return false;
		}

		private bool AnyValidateBegin(BasicRagdoll rg, out Scp3114HudTranslation error)
		{
			if (!rg.Info.RoleType.TryGetRoleTemplate<HumanRole>(out var _))
			{
				error = Scp3114HudTranslation.RagdollErrorNotHuman;
				return false;
			}
			if (rg.Info.Handler is Scp3114DamageHandler { Subtype: Scp3114DamageHandler.HandlerType.SkinSteal })
			{
				error = Scp3114HudTranslation.RagdollErrorPreviouslyUsed;
				return false;
			}
			if (base.CastRole.Disguised)
			{
				error = Scp3114HudTranslation.RagdollErrorAlreadyDisguised;
				return false;
			}
			error = Scp3114HudTranslation.IdentityStolenWarning;
			return true;
		}

		private void ServerOnRagdollCreated(ReferenceHub owner, BasicRagdoll ragdoll)
		{
			if (!(owner == null) && owner.roleManager.CurrentRole is HumanRole humanRole)
			{
				_prevUnitIds[ragdoll] = humanRole.UnitNameId;
			}
		}
	}
}
