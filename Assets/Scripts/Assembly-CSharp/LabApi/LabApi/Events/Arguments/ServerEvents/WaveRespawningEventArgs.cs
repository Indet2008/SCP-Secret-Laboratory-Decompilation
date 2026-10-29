namespace LabApi.Events.Arguments.ServerEvents
{
	public class WaveRespawningEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool IsAllowed { get; set; }

		public global::LabApi.Features.Wrappers.RespawnWave Wave { get; }

		public global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> SpawningPlayers => Roles.Keys;

		public global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Player, global::PlayerRoles.RoleTypeId> Roles { get; private set; }

		public WaveRespawningEventArgs(global::Respawning.Waves.SpawnableWaveBase wave, global::System.Collections.Generic.Dictionary<ReferenceHub, global::PlayerRoles.RoleTypeId> roles)
		{
			IsAllowed = true;
			Wave = global::LabApi.Features.Wrappers.RespawnWaves.Get(wave);
			Roles = global::UnityEngine.Pool.CollectionPool<global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Player, global::PlayerRoles.RoleTypeId>, global::System.Collections.Generic.KeyValuePair<global::LabApi.Features.Wrappers.Player, global::PlayerRoles.RoleTypeId>>.Get();
			foreach (global::System.Collections.Generic.KeyValuePair<ReferenceHub, global::PlayerRoles.RoleTypeId> role in roles)
			{
				Roles.Add(global::LabApi.Features.Wrappers.Player.Get(role.Key), role.Value);
			}
		}
	}
}
