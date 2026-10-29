namespace LabApi.Events.Handlers
{
	public static class ServerEvents
	{
		public static event global::LabApi.Events.LabEventHandler? WaitingForPlayers;

		public static event global::LabApi.Events.LabEventHandler? RoundRestarted;

		public static event global::LabApi.Events.LabEventHandler? Shutdown;

		public static event global::LabApi.Events.LabEventHandler? DeadmanSequenceActivated;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.DeadmanSequenceActivatingEventArgs>? DeadmanSequenceActivating;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.RoundEndingConditionsCheckEventArgs>? RoundEndingConditionsCheck;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.RoundEndingEventArgs>? RoundEnding;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.RoundEndedEventArgs>? RoundEnded;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.RoundStartingEventArgs>? RoundStarting;

		public static event global::LabApi.Events.LabEventHandler? RoundStarted;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.BanIssuingEventArgs>? BanIssuing;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.BanIssuedEventArgs>? BanIssued;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.BanRevokingEventArgs>? BanRevoking;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.BanRevokedEventArgs>? BanRevoked;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.BanUpdatingEventArgs>? BanUpdating;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.BanUpdatedEventArgs>? BanUpdated;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.CommandExecutingEventArgs>? CommandExecuting;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.CommandExecutedEventArgs>? CommandExecuted;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.CassieQueuingScpTerminationEventArgs>? CassieQueuingScpTermination;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.CassieQueuedScpTerminationEventArgs>? CassieQueuedScpTermination;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.WaveRespawningEventArgs>? WaveRespawning;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.WaveRespawnedEventArgs>? WaveRespawned;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.WaveTeamSelectingEventArgs>? WaveTeamSelecting;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.WaveTeamSelectedEventArgs>? WaveTeamSelected;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.LczDecontaminationAnnouncedEventArgs>? LczDecontaminationAnnounced;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.LczDecontaminationStartingEventArgs>? LczDecontaminationStarting;

		public static event global::LabApi.Events.LabEventHandler? LczDecontaminationStarted;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.MapGeneratingEventArgs>? MapGenerating;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.MapGeneratedEventArgs>? MapGenerated;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.PickupCreatedEventArgs>? PickupCreated;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.PickupDestroyedEventArgs>? PickupDestroyed;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.SendingAdminChatEventArgs>? SendingAdminChat;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.SentAdminChatEventArgs>? SentAdminChat;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.ItemSpawningEventArgs>? ItemSpawning;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.ItemSpawnedEventArgs>? ItemSpawned;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.CassieAnnouncingEventArgs>? CassieAnnouncing;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.CassieAnnouncedEventArgs>? CassieAnnounced;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.ProjectileExplodingEventArgs>? ProjectileExploding;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.ProjectileExplodedEventArgs>? ProjectileExploded;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.ExplosionSpawningEventArgs>? ExplosionSpawning;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.ExplosionSpawnedEventArgs>? ExplosionSpawned;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.GeneratorActivatingEventArgs>? GeneratorActivating;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.GeneratorActivatedEventArgs>? GeneratorActivated;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.ElevatorSequenceChangedEventArgs>? ElevatorSequenceChanged;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.ModifyingFactionInfluenceEventArgs>? ModifyingFactionInfluence;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.ModifiedFactionInfluenceEventArgs>? ModifiedFactionInfluence;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.AchievingMilestoneEventArgs>? AchievingMilestone;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.AchievedMilestoneEventArgs>? AchievedMilestone;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.BlastDoorChangingEventArgs>? BlastDoorChanging;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.BlastDoorChangedEventArgs>? BlastDoorChanged;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.RoomLightChangedEventArgs>? RoomLightChanged;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.RoomColorChangedEventArgs>? RoomColorChanged;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.DoorLockChangedEventArgs>? DoorLockChanged;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.DoorRepairingEventArgs>? DoorRepairing;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.DoorRepairedEventArgs>? DoorRepaired;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.DoorDamagingEventArgs>? DoorDamaging;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.DoorDamagedEventArgs>? DoorDamaged;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.CheckpointDoorSequenceChangingEventArgs>? CheckpointDoorSequenceChanging;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ServerEvents.CheckpointDoorSequenceChangedEventArgs>? CheckpointDoorSequenceChanged;

		public static event global::LabApi.Events.LabEventHandler? PluginsEnabled;

		public static void OnWaitingForPlayers()
		{
			WaitingForPlayers.InvokeEvent();
		}

		public static void OnRoundRestarted()
		{
			RoundRestarted.InvokeEvent();
		}

		public static void OnShutdown()
		{
			Shutdown.InvokeEvent();
		}

		public static void OnDeadmanSequenceActivated()
		{
			DeadmanSequenceActivated.InvokeEvent();
		}

		public static void OnDeadmanSequenceActivating(global::LabApi.Events.Arguments.ServerEvents.DeadmanSequenceActivatingEventArgs ev)
		{
			DeadmanSequenceActivating.InvokeEvent(ev);
		}

		public static void OnRoundEndingConditionsCheck(global::LabApi.Events.Arguments.ServerEvents.RoundEndingConditionsCheckEventArgs ev)
		{
			RoundEndingConditionsCheck.InvokeEvent(ev);
		}

		public static void OnRoundEnding(global::LabApi.Events.Arguments.ServerEvents.RoundEndingEventArgs ev)
		{
			RoundEnding.InvokeEvent(ev);
		}

		public static void OnRoundEnded(global::LabApi.Events.Arguments.ServerEvents.RoundEndedEventArgs ev)
		{
			RoundEnded.InvokeEvent(ev);
		}

		public static void OnRoundStarting(global::LabApi.Events.Arguments.ServerEvents.RoundStartingEventArgs ev)
		{
			RoundStarting.InvokeEvent(ev);
		}

		public static void OnRoundStarted()
		{
			RoundStarted.InvokeEvent();
		}

		public static void OnBanIssuing(global::LabApi.Events.Arguments.ServerEvents.BanIssuingEventArgs ev)
		{
			BanIssuing.InvokeEvent(ev);
		}

		public static void OnBanIssued(global::LabApi.Events.Arguments.ServerEvents.BanIssuedEventArgs ev)
		{
			BanIssued.InvokeEvent(ev);
		}

		public static void OnBanRevoking(global::LabApi.Events.Arguments.ServerEvents.BanRevokingEventArgs ev)
		{
			BanRevoking.InvokeEvent(ev);
		}

		public static void OnBanRevoked(global::LabApi.Events.Arguments.ServerEvents.BanRevokedEventArgs ev)
		{
			BanRevoked.InvokeEvent(ev);
		}

		public static void OnBanUpdating(global::LabApi.Events.Arguments.ServerEvents.BanUpdatingEventArgs ev)
		{
			BanUpdating.InvokeEvent(ev);
		}

		public static void OnBanUpdated(global::LabApi.Events.Arguments.ServerEvents.BanUpdatedEventArgs ev)
		{
			BanUpdated.InvokeEvent(ev);
		}

		public static void OnCommandExecuting(global::LabApi.Events.Arguments.ServerEvents.CommandExecutingEventArgs ev)
		{
			CommandExecuting.InvokeEvent(ev);
		}

		public static void OnCommandExecuted(global::LabApi.Events.Arguments.ServerEvents.CommandExecutedEventArgs ev)
		{
			CommandExecuted.InvokeEvent(ev);
		}

		public static void OnCassieQueuingScpTermination(global::LabApi.Events.Arguments.ServerEvents.CassieQueuingScpTerminationEventArgs ev)
		{
			CassieQueuingScpTermination.InvokeEvent(ev);
		}

		public static void OnCassieQueuedScpTermination(global::LabApi.Events.Arguments.ServerEvents.CassieQueuedScpTerminationEventArgs ev)
		{
			CassieQueuedScpTermination.InvokeEvent(ev);
		}

		public static void OnWaveRespawning(global::LabApi.Events.Arguments.ServerEvents.WaveRespawningEventArgs ev)
		{
			WaveRespawning.InvokeEvent(ev);
		}

		public static void OnWaveRespawned(global::LabApi.Events.Arguments.ServerEvents.WaveRespawnedEventArgs ev)
		{
			WaveRespawned.InvokeEvent(ev);
		}

		public static void OnWaveTeamSelecting(global::LabApi.Events.Arguments.ServerEvents.WaveTeamSelectingEventArgs ev)
		{
			WaveTeamSelecting.InvokeEvent(ev);
		}

		public static void OnWaveTeamSelected(global::LabApi.Events.Arguments.ServerEvents.WaveTeamSelectedEventArgs ev)
		{
			WaveTeamSelected.InvokeEvent(ev);
		}

		public static void OnLczDecontaminationAnnounced(global::LabApi.Events.Arguments.ServerEvents.LczDecontaminationAnnouncedEventArgs ev)
		{
			LczDecontaminationAnnounced.InvokeEvent(ev);
		}

		public static void OnLczDecontaminationStarting(global::LabApi.Events.Arguments.ServerEvents.LczDecontaminationStartingEventArgs ev)
		{
			LczDecontaminationStarting.InvokeEvent(ev);
		}

		public static void OnLczDecontaminationStarted()
		{
			LczDecontaminationStarted.InvokeEvent();
		}

		public static void OnMapGenerating(global::LabApi.Events.Arguments.ServerEvents.MapGeneratingEventArgs ev)
		{
			MapGenerating.InvokeEvent(ev);
		}

		public static void OnMapGenerated(global::LabApi.Events.Arguments.ServerEvents.MapGeneratedEventArgs ev)
		{
			MapGenerated.InvokeEvent(ev);
		}

		public static void OnPickupCreated(global::LabApi.Events.Arguments.ServerEvents.PickupCreatedEventArgs ev)
		{
			PickupCreated.InvokeEvent(ev);
		}

		public static void OnPickupDestroyed(global::LabApi.Events.Arguments.ServerEvents.PickupDestroyedEventArgs ev)
		{
			PickupDestroyed.InvokeEvent(ev);
		}

		public static void OnSendingAdminChat(global::LabApi.Events.Arguments.ServerEvents.SendingAdminChatEventArgs ev)
		{
			SendingAdminChat.InvokeEvent(ev);
		}

		public static void OnSentAdminChat(global::LabApi.Events.Arguments.ServerEvents.SentAdminChatEventArgs ev)
		{
			SentAdminChat.InvokeEvent(ev);
		}

		public static void OnItemSpawning(global::LabApi.Events.Arguments.ServerEvents.ItemSpawningEventArgs ev)
		{
			ItemSpawning.InvokeEvent(ev);
		}

		public static void OnItemSpawned(global::LabApi.Events.Arguments.ServerEvents.ItemSpawnedEventArgs ev)
		{
			ItemSpawned.InvokeEvent(ev);
		}

		public static void OnCassieAnnouncing(global::LabApi.Events.Arguments.ServerEvents.CassieAnnouncingEventArgs ev)
		{
			CassieAnnouncing.InvokeEvent(ev);
		}

		public static void OnCassieAnnounced(global::LabApi.Events.Arguments.ServerEvents.CassieAnnouncedEventArgs ev)
		{
			CassieAnnounced.InvokeEvent(ev);
		}

		public static void OnProjectileExploding(global::LabApi.Events.Arguments.ServerEvents.ProjectileExplodingEventArgs ev)
		{
			ProjectileExploding.InvokeEvent(ev);
		}

		public static void OnProjectileExploded(global::LabApi.Events.Arguments.ServerEvents.ProjectileExplodedEventArgs ev)
		{
			ProjectileExploded.InvokeEvent(ev);
		}

		public static void OnExplosionSpawning(global::LabApi.Events.Arguments.ServerEvents.ExplosionSpawningEventArgs ev)
		{
			ExplosionSpawning.InvokeEvent(ev);
		}

		public static void OnExplosionSpawned(global::LabApi.Events.Arguments.ServerEvents.ExplosionSpawnedEventArgs ev)
		{
			ExplosionSpawned.InvokeEvent(ev);
		}

		public static void OnGeneratorActivating(global::LabApi.Events.Arguments.ServerEvents.GeneratorActivatingEventArgs ev)
		{
			GeneratorActivating.InvokeEvent(ev);
		}

		public static void OnGeneratorActivated(global::LabApi.Events.Arguments.ServerEvents.GeneratorActivatedEventArgs ev)
		{
			GeneratorActivated.InvokeEvent(ev);
		}

		public static void OnElevatorSequenceChanged(global::LabApi.Events.Arguments.ServerEvents.ElevatorSequenceChangedEventArgs ev)
		{
			ElevatorSequenceChanged.InvokeEvent(ev);
		}

		public static void OnModifyingFactionInfluence(global::LabApi.Events.Arguments.ServerEvents.ModifyingFactionInfluenceEventArgs ev)
		{
			ModifyingFactionInfluence.InvokeEvent(ev);
		}

		public static void OnModifiedFactionInfluence(global::LabApi.Events.Arguments.ServerEvents.ModifiedFactionInfluenceEventArgs ev)
		{
			ModifiedFactionInfluence.InvokeEvent(ev);
		}

		public static void OnAchievingMilestone(global::LabApi.Events.Arguments.ServerEvents.AchievingMilestoneEventArgs ev)
		{
			AchievingMilestone.InvokeEvent(ev);
		}

		public static void OnAchievedMilestone(global::LabApi.Events.Arguments.ServerEvents.AchievedMilestoneEventArgs ev)
		{
			AchievedMilestone.InvokeEvent(ev);
		}

		public static void OnBlastDoorChanging(global::LabApi.Events.Arguments.ServerEvents.BlastDoorChangingEventArgs ev)
		{
			BlastDoorChanging.InvokeEvent(ev);
		}

		public static void OnBlastDoorChanged(global::LabApi.Events.Arguments.ServerEvents.BlastDoorChangedEventArgs ev)
		{
			BlastDoorChanged.InvokeEvent(ev);
		}

		public static void OnRoomLightChanged(global::LabApi.Events.Arguments.ServerEvents.RoomLightChangedEventArgs ev)
		{
			RoomLightChanged.InvokeEvent(ev);
		}

		public static void OnRoomColorChanged(global::LabApi.Events.Arguments.ServerEvents.RoomColorChangedEventArgs ev)
		{
			RoomColorChanged.InvokeEvent(ev);
		}

		public static void OnDoorLockChanged(global::LabApi.Events.Arguments.ServerEvents.DoorLockChangedEventArgs ev)
		{
			DoorLockChanged.InvokeEvent(ev);
		}

		public static void OnDoorRepairing(global::LabApi.Events.Arguments.ServerEvents.DoorRepairingEventArgs ev)
		{
			DoorRepairing.InvokeEvent(ev);
		}

		public static void OnDoorRepaired(global::LabApi.Events.Arguments.ServerEvents.DoorRepairedEventArgs ev)
		{
			DoorRepaired.InvokeEvent(ev);
		}

		public static void OnDoorDamaging(global::LabApi.Events.Arguments.ServerEvents.DoorDamagingEventArgs ev)
		{
			DoorDamaging.InvokeEvent(ev);
		}

		public static void OnDoorDamaged(global::LabApi.Events.Arguments.ServerEvents.DoorDamagedEventArgs ev)
		{
			DoorDamaged.InvokeEvent(ev);
		}

		public static void OnCheckpointDoorSequenceChanging(global::LabApi.Events.Arguments.ServerEvents.CheckpointDoorSequenceChangingEventArgs ev)
		{
			CheckpointDoorSequenceChanging.InvokeEvent(ev);
		}

		public static void OnCheckpointDoorSequenceChanged(global::LabApi.Events.Arguments.ServerEvents.CheckpointDoorSequenceChangedEventArgs ev)
		{
			CheckpointDoorSequenceChanged.InvokeEvent(ev);
		}

		public static void OnPluginsEnabled()
		{
			PluginsEnabled.InvokeEvent();
		}
	}
}
