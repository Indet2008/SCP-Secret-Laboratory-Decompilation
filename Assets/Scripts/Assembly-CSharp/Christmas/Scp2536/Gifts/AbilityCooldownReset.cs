using System;
using Mirror;
using PlayerRoles;
using PlayerRoles.PlayableScps.Scp049;
using PlayerRoles.PlayableScps.Scp096;
using PlayerRoles.PlayableScps.Scp173;
using PlayerRoles.PlayableScps.Scp939;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace Christmas.Scp2536.Gifts
{
	public class AbilityCooldownReset : Scp2536AnomalousGiftBase
	{
		public override UrgencyLevel Urgency => UrgencyLevel.Five;

		public override void ServerGrant(ReferenceHub hub)
		{
			base.ServerGrant(hub);
			PlayerRoleBase currentRole = hub.roleManager.CurrentRole;
			if (!(currentRole is Scp173Role role))
			{
				if (!(currentRole is Scp939Role role2))
				{
					if (!(currentRole is Scp049Role role3))
					{
						if (currentRole is Scp096Role role4)
						{
							ClearCooldown(role4, (Scp096ChargeAbility s) =>
							{
								s.Cooldown.Clear();
							});
						}
						else
						{
							Debug.LogWarning("Attempted to gift AbilityCooldownReset to " + currentRole.GetType().Name + " with no defined reward.");
						}
					}
					else
					{
						ClearCooldown(role3, (Scp049SenseAbility s) =>
						{
							s.Cooldown.Clear();
						});
						ClearCooldown(role3, (Scp049CallAbility s) =>
						{
							s.Cooldown.Clear();
						});
					}
				}
				else
				{
					ClearCooldown(role2, (Scp939AmnesticCloudAbility s) =>
					{
						s.Cooldown.Clear();
					});
				}
			}
			else
			{
				ClearCooldown(role, (Scp173BreakneckSpeedsAbility s) =>
				{
					s.Cooldown.Clear();
				});
				ClearCooldown(role, (Scp173TantrumAbility s) =>
				{
					s.Cooldown.Clear();
				});
			}
		}

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (!base.CanBeGranted(hub))
			{
				return false;
			}
			PlayerRoleBase currentRole = hub.roleManager.CurrentRole;
			if (!(currentRole is Scp173Role role))
			{
				if (!(currentRole is Scp939Role role2))
				{
					if (!(currentRole is Scp049Role role3))
					{
						if (currentRole is Scp096Role role4)
						{
							return IsOnCooldown(role4, (Scp096ChargeAbility s) => s.Cooldown);
						}
						Debug.LogWarning("Attempted to gift AbilityCooldownReset to " + currentRole.GetType().Name + " with no defined reward.");
						return false;
					}
					bool flag = IsOnCooldown(role3, (Scp049SenseAbility s) => s.Cooldown);
					bool flag2 = IsOnCooldown(role3, (Scp049CallAbility s) => s.Cooldown);
					return flag | flag2;
				}
				return IsOnCooldown(role2, (Scp939AmnesticCloudAbility s) => s.Cooldown);
			}
			bool flag3 = IsOnCooldown(role, (Scp173BreakneckSpeedsAbility s) => s.Cooldown);
			bool flag4 = IsOnCooldown(role, (Scp173TantrumAbility s) => s.Cooldown);
			return flag3 | flag4;
		}

		private static bool IsOnCooldown<TSubroutine>(ISubroutinedRole role, Func<TSubroutine, AbilityCooldown> cooldownCheck) where TSubroutine : SubroutineBase
		{
			if (!role.SubroutineModule.TryGetSubroutine<TSubroutine>(out var subroutine))
			{
				return false;
			}
			return !(cooldownCheck?.Invoke(subroutine)).IsReady;
		}

		private static void ClearCooldown<TSubroutine>(ISubroutinedRole role, Action<TSubroutine> cooldownResetAction, bool sendResetMessage = true) where TSubroutine : SubroutineBase
		{
			if (role.SubroutineModule.TryGetSubroutine<TSubroutine>(out var subroutine))
			{
				cooldownResetAction?.Invoke(subroutine);
				if (sendResetMessage)
				{
					UpdateCooldown(subroutine);
				}
			}
		}

		private static void UpdateCooldown(SubroutineBase subroutine)
		{
			NetworkServer.SendToReady(new SubroutineMessage(subroutine, isConfirmation: true));
		}
	}
}
