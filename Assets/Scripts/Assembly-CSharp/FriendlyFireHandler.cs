using Mirror;
using PlayerRoles;
using PlayerStatsSystem;

internal class FriendlyFireHandler
{
	private static bool _eventsAssigned;

	internal readonly RoundFriendlyFireDetector Round;

	internal readonly LifeFriendlyFireDetector Life;

	internal readonly WindowFriendlyFireDetector Window;

	internal readonly RespawnFriendlyFireDetector Respawn;

	internal FriendlyFireHandler(ReferenceHub hub)
	{
		Round = new RoundFriendlyFireDetector(hub);
		Life = new LifeFriendlyFireDetector(hub);
		Window = new WindowFriendlyFireDetector(hub);
		Respawn = new RespawnFriendlyFireDetector(hub);
		if (!_eventsAssigned)
		{
			PlayerStats.OnAnyPlayerDamaged += OnAnyDamaged;
			PlayerStats.OnAnyPlayerDied += OnAnyDied;
			_eventsAssigned = true;
		}
	}

	private static void OnAnyDied(ReferenceHub deadPlayer, DamageHandlerBase handler)
	{
		if (!IsFriendlyFire(deadPlayer, handler, out var attackerHandler))
		{
			return;
		}
		ReferenceHub hub = attackerHandler.Attacker.Hub;
		if (hub == null)
		{
			if (FriendlyFireConfig.ExplosionAfterDisconnecting && attackerHandler is ExplosionDamageHandler)
			{
				FriendlyFireDetector.TakeAction(attackerHandler.Attacker, ref FriendlyFireConfig.ExplosionAfterDisconnectingAction, "Explosion After Disconnection", ref FriendlyFireConfig.ExplosionAfterDisconnectingTime, ref FriendlyFireConfig.ExplosionAfterDisconnectingBanReason, ref FriendlyFireConfig.ExplosionAfterDisconnectingBanReason, ref FriendlyFireConfig.ExplosionAfterDisconnectingAdminMessage, ref FriendlyFireConfig.ExplosionAfterDisconnectingBroadcastMessage, ref FriendlyFireConfig.ExplosionAfterDisconnectingWebhook);
			}
		}
		else if (!hub.FriendlyFireHandler.Respawn.RegisterKill() && !hub.FriendlyFireHandler.Window.RegisterKill() && !hub.FriendlyFireHandler.Life.RegisterKill())
		{
			hub.FriendlyFireHandler.Round.RegisterKill();
		}
	}

	private static void OnAnyDamaged(ReferenceHub damagedPlayer, DamageHandlerBase handler)
	{
		if (!IsFriendlyFire(damagedPlayer, handler, out var attackerHandler))
		{
			return;
		}
		ReferenceHub hub = attackerHandler.Attacker.Hub;
		if (!(hub == null))
		{
			float damage = attackerHandler.Damage;
			if (!hub.FriendlyFireHandler.Respawn.RegisterDamage(damage) && !hub.FriendlyFireHandler.Window.RegisterDamage(damage) && !hub.FriendlyFireHandler.Life.RegisterDamage(damage))
			{
				hub.FriendlyFireHandler.Round.RegisterDamage(damage);
			}
		}
	}

	private static bool IsFriendlyFire(ReferenceHub damagedPlayer, DamageHandlerBase handler, out AttackerDamageHandler attackerHandler)
	{
		attackerHandler = null;
		if (FriendlyFireConfig.PauseDetector || !NetworkServer.active)
		{
			return false;
		}
		if (!(handler is AttackerDamageHandler { IgnoreFriendlyFireDetector: false } attackerDamageHandler))
		{
			return false;
		}
		attackerHandler = attackerDamageHandler;
		if (!attackerHandler.Attacker.Role.TryGetRoleTemplate<PlayerRoleBase>(out var result))
		{
			return false;
		}
		if (damagedPlayer.GetFaction() != result.Team.GetFaction())
		{
			return false;
		}
		ReferenceHub hub = attackerHandler.Attacker.Hub;
		if (hub != null && (hub == damagedPlayer || PermissionsHandler.IsPermitted(hub.serverRoles.Permissions, PlayerPermissions.FriendlyFireDetectorImmunity)))
		{
			return false;
		}
		if (FriendlyFireConfig.IgnoreClassDTeamkills && damagedPlayer.GetRoleId() == RoleTypeId.ClassD)
		{
			return attackerHandler.Attacker.Role != RoleTypeId.ClassD;
		}
		return true;
	}
}
