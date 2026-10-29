namespace LabApi.Events.CustomHandlers
{
	public abstract class CustomEventsHandler
	{
		internal global::System.Collections.Generic.Dictionary<global::System.Reflection.EventInfo, global::System.Delegate> InternalEvents { get; } = new global::System.Collections.Generic.Dictionary<global::System.Reflection.EventInfo, global::System.Delegate>();

		public virtual void OnObjectiveCompleting(global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletingBaseEventArgs ev)
		{
		}

		public virtual void OnObjectiveCompleted(global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletedBaseEventArgs ev)
		{
		}

		public virtual void OnObjectiveKillingEnemyCompleting(global::LabApi.Events.Arguments.ObjectiveEvents.EnemyKillingObjectiveEventArgs ev)
		{
		}

		public virtual void OnObjectiveKilledEnemyCompleted(global::LabApi.Events.Arguments.ObjectiveEvents.EnemyKilledObjectiveEventArgs ev)
		{
		}

		public virtual void OnObjectiveEscapingCompleting(global::LabApi.Events.Arguments.ObjectiveEvents.EscapingObjectiveEventArgs ev)
		{
		}

		public virtual void OnObjectiveEscapedCompleted(global::LabApi.Events.Arguments.ObjectiveEvents.EscapedObjectiveEventArgs ev)
		{
		}

		public virtual void OnObjectiveActivatingGeneratorCompleting(global::LabApi.Events.Arguments.ObjectiveEvents.GeneratorActivatingObjectiveEventArgs ev)
		{
		}

		public virtual void OnObjectiveActivatedGeneratorCompleted(global::LabApi.Events.Arguments.ObjectiveEvents.GeneratorActivatedObjectiveEventArgs ev)
		{
		}

		public virtual void OnObjectiveDamagingScpCompleting(global::LabApi.Events.Arguments.ObjectiveEvents.ScpDamagingObjectiveEventArgs ev)
		{
		}

		public virtual void OnObjectiveDamagedScpCompleted(global::LabApi.Events.Arguments.ObjectiveEvents.ScpDamagedObjectiveEventArgs ev)
		{
		}

		public virtual void OnObjectivePickingScpItemCompleting(global::LabApi.Events.Arguments.ObjectiveEvents.ScpItemPickingObjectiveEventArgs ev)
		{
		}

		public virtual void OnObjectivePickedScpItemCompleted(global::LabApi.Events.Arguments.ObjectiveEvents.ScpItemPickedObjectiveEventArgs ev)
		{
		}

		public virtual void OnPlayerJoined(global::LabApi.Events.Arguments.PlayerEvents.PlayerJoinedEventArgs ev)
		{
		}

		public virtual void OnPlayerLeft(global::LabApi.Events.Arguments.PlayerEvents.PlayerLeftEventArgs ev)
		{
		}

		public virtual void OnPlayerReceivingVoiceMessage(global::LabApi.Events.Arguments.PlayerEvents.PlayerReceivingVoiceMessageEventArgs ev)
		{
		}

		public virtual void OnPlayerSendingVoiceMessage(global::LabApi.Events.Arguments.PlayerEvents.PlayerSendingVoiceMessageEventArgs ev)
		{
		}

		public virtual void OnPlayerPreAuthenticating(global::LabApi.Events.Arguments.PlayerEvents.PlayerPreAuthenticatingEventArgs ev)
		{
		}

		public virtual void OnPlayerPreAuthenticated(global::LabApi.Events.Arguments.PlayerEvents.PlayerPreAuthenticatedEventArgs ev)
		{
		}

		public virtual void OnPlayerUsingIntercom(global::LabApi.Events.Arguments.PlayerEvents.PlayerUsingIntercomEventArgs ev)
		{
		}

		public virtual void OnPlayerUsedIntercom(global::LabApi.Events.Arguments.PlayerEvents.PlayerUsedIntercomEventArgs ev)
		{
		}

		public virtual void OnPlayerBanning(global::LabApi.Events.Arguments.PlayerEvents.PlayerBanningEventArgs ev)
		{
		}

		public virtual void OnPlayerBanned(global::LabApi.Events.Arguments.PlayerEvents.PlayerBannedEventArgs ev)
		{
		}

		public virtual void OnPlayerKicking(global::LabApi.Events.Arguments.PlayerEvents.PlayerKickingEventArgs ev)
		{
		}

		public virtual void OnPlayerKicked(global::LabApi.Events.Arguments.PlayerEvents.PlayerKickedEventArgs ev)
		{
		}

		public virtual void OnPlayerMuting(global::LabApi.Events.Arguments.PlayerEvents.PlayerMutingEventArgs ev)
		{
		}

		public virtual void OnPlayerMuted(global::LabApi.Events.Arguments.PlayerEvents.PlayerMutedEventArgs ev)
		{
		}

		public virtual void OnPlayerUnmuting(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnmutingEventArgs ev)
		{
		}

		public virtual void OnPlayerUnmuted(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnmutedEventArgs ev)
		{
		}

		public virtual void OnPlayerReportingCheater(global::LabApi.Events.Arguments.PlayerEvents.PlayerReportingCheaterEventArgs ev)
		{
		}

		public virtual void OnPlayerReportedCheater(global::LabApi.Events.Arguments.PlayerEvents.PlayerReportedCheaterEventArgs ev)
		{
		}

		public virtual void OnPlayerReportingPlayer(global::LabApi.Events.Arguments.PlayerEvents.PlayerReportingPlayerEventArgs ev)
		{
		}

		public virtual void OnPlayerReportedPlayer(global::LabApi.Events.Arguments.PlayerEvents.PlayerReportedPlayerEventArgs ev)
		{
		}

		public virtual void OnPlayerTogglingNoclip(global::LabApi.Events.Arguments.PlayerEvents.PlayerTogglingNoclipEventArgs ev)
		{
		}

		public virtual void OnPlayerToggledNoclip(global::LabApi.Events.Arguments.PlayerEvents.PlayerToggledNoclipEventArgs ev)
		{
		}

		public virtual void OnPlayerRequestingRaPlayerList(global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestingRaPlayerListEventArgs ev)
		{
		}

		public virtual void OnPlayerRequestedRaPlayerList(global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestedRaPlayerListEventArgs ev)
		{
		}

		public virtual void OnPlayerRaPlayerListAddingPlayer(global::LabApi.Events.Arguments.PlayerEvents.PlayerRaPlayerListAddingPlayerEventArgs ev)
		{
		}

		public virtual void OnPlayerRaPlayerListAddedPlayer(global::LabApi.Events.Arguments.PlayerEvents.PlayerRaPlayerListAddedPlayerEventArgs ev)
		{
		}

		public virtual void OnPlayerRequestedCustomRaInfo(global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestedCustomRaInfoEventArgs ev)
		{
		}

		public virtual void OnPlayerRequestingRaPlayersInfo(global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestingRaPlayersInfoEventArgs ev)
		{
		}

		public virtual void OnPlayerRequestedRaPlayersInfo(global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestedRaPlayersInfoEventArgs ev)
		{
		}

		public virtual void OnPlayerRequestingRaPlayerInfo(global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestingRaPlayerInfoEventArgs ev)
		{
		}

		public virtual void OnPlayerRequestedRaPlayerInfo(global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestedRaPlayerInfoEventArgs ev)
		{
		}

		public virtual void OnPlayerChangingBadgeVisibility(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingBadgeVisibilityEventArgs ev)
		{
		}

		public virtual void OnPlayerChangedBadgeVisibility(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedBadgeVisibilityEventArgs ev)
		{
		}

		public virtual void OnPlayerChangingNickname(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingNicknameEventArgs ev)
		{
		}

		public virtual void OnPlayerChangedNickname(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedNicknameEventArgs ev)
		{
		}

		public virtual void OnPlayerGroupChanging(global::LabApi.Events.Arguments.PlayerEvents.PlayerGroupChangingEventArgs ev)
		{
		}

		public virtual void OnPlayerGroupChanged(global::LabApi.Events.Arguments.PlayerEvents.PlayerGroupChangedEventArgs ev)
		{
		}

		public virtual void OnPlayerUpdatingEffect(global::LabApi.Events.Arguments.PlayerEvents.PlayerEffectUpdatingEventArgs ev)
		{
		}

		public virtual void OnPlayerUpdatedEffect(global::LabApi.Events.Arguments.PlayerEvents.PlayerEffectUpdatedEventArgs ev)
		{
		}

		public virtual void OnPlayerDying(global::LabApi.Events.Arguments.PlayerEvents.PlayerDyingEventArgs ev)
		{
		}

		public virtual void OnPlayerDeath(global::LabApi.Events.Arguments.PlayerEvents.PlayerDeathEventArgs ev)
		{
		}

		public virtual void OnPlayerHurting(global::LabApi.Events.Arguments.PlayerEvents.PlayerHurtingEventArgs ev)
		{
		}

		public virtual void OnPlayerHurt(global::LabApi.Events.Arguments.PlayerEvents.PlayerHurtEventArgs ev)
		{
		}

		public virtual void OnPlayerChangingRole(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingRoleEventArgs ev)
		{
		}

		public virtual void OnPlayerChangedRole(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedRoleEventArgs ev)
		{
		}

		public virtual void OnPlayerCuffing(global::LabApi.Events.Arguments.PlayerEvents.PlayerCuffingEventArgs ev)
		{
		}

		public virtual void OnPlayerCuffed(global::LabApi.Events.Arguments.PlayerEvents.PlayerCuffedEventArgs ev)
		{
		}

		public virtual void OnPlayerUncuffing(global::LabApi.Events.Arguments.PlayerEvents.PlayerUncuffingEventArgs ev)
		{
		}

		public virtual void OnPlayerUncuffed(global::LabApi.Events.Arguments.PlayerEvents.PlayerUncuffedEventArgs ev)
		{
		}

		public virtual void OnPlayerReceivingLoadout(global::LabApi.Events.Arguments.PlayerEvents.PlayerReceivingLoadoutEventArgs ev)
		{
		}

		public virtual void OnPlayerReceivedLoadout(global::LabApi.Events.Arguments.PlayerEvents.PlayerReceivedLoadoutEventArgs ev)
		{
		}

		public virtual void OnPlayerSpawning(global::LabApi.Events.Arguments.PlayerEvents.PlayerSpawningEventArgs ev)
		{
		}

		public virtual void OnPlayerSpawned(global::LabApi.Events.Arguments.PlayerEvents.PlayerSpawnedEventArgs ev)
		{
		}

		public virtual void OnPlayerChangingItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingItemEventArgs ev)
		{
		}

		public virtual void OnPlayerChangedItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedItemEventArgs ev)
		{
		}

		public virtual void OnPlayerDroppingAmmo(global::LabApi.Events.Arguments.PlayerEvents.PlayerDroppingAmmoEventArgs ev)
		{
		}

		public virtual void OnPlayerDroppedAmmo(global::LabApi.Events.Arguments.PlayerEvents.PlayerDroppedAmmoEventArgs ev)
		{
		}

		public virtual void OnPlayerDroppingItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerDroppingItemEventArgs ev)
		{
		}

		public virtual void OnPlayerDroppedItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerDroppedItemEventArgs ev)
		{
		}

		public virtual void OnPlayerPickingUpAmmo(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickingUpAmmoEventArgs ev)
		{
		}

		public virtual void OnPlayerPickedUpAmmo(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickedUpAmmoEventArgs ev)
		{
		}

		public virtual void OnPlayerPickingUpArmor(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickingUpArmorEventArgs ev)
		{
		}

		public virtual void OnPlayerPickedUpArmor(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickedUpArmorEventArgs ev)
		{
		}

		public virtual void OnPlayerPickingUpItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickingUpItemEventArgs ev)
		{
		}

		public virtual void OnPlayerPickedUpItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickedUpItemEventArgs ev)
		{
		}

		public virtual void OnPlayerPickingUpScp330(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickingUpScp330EventArgs ev)
		{
		}

		public virtual void OnPlayerPickedUpScp330(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickedUpScp330EventArgs ev)
		{
		}

		public virtual void OnPlayerSearchedAmmo(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchedAmmoEventArgs ev)
		{
		}

		public virtual void OnPlayerSearchingArmor(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchingArmorEventArgs ev)
		{
		}

		public virtual void OnPlayerSearchedArmor(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchedArmorEventArgs ev)
		{
		}

		public virtual void OnPlayerSearchingPickup(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchingPickupEventArgs ev)
		{
		}

		public virtual void OnPlayerInteractedToy(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedToyEventArgs ev)
		{
		}

		public virtual void OnPlayerSearchedPickup(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchedPickupEventArgs ev)
		{
		}

		public virtual void OnPlayerSearchingAmmo(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchingAmmoEventArgs ev)
		{
		}

		public virtual void OnPlayerThrowingItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerThrowingItemEventArgs ev)
		{
		}

		public virtual void OnPlayerThrewItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerThrewItemEventArgs ev)
		{
		}

		public virtual void OnPlayerThrowingProjectile(global::LabApi.Events.Arguments.PlayerEvents.PlayerThrowingProjectileEventArgs ev)
		{
		}

		public virtual void OnPlayerThrewProjectile(global::LabApi.Events.Arguments.PlayerEvents.PlayerThrewProjectileEventArgs ev)
		{
		}

		public virtual void OnPlayerInspectingKeycard(global::LabApi.Events.Arguments.PlayerEvents.PlayerInspectingKeycardEventArgs ev)
		{
		}

		public virtual void OnPlayerInspectedKeycard(global::LabApi.Events.Arguments.PlayerEvents.PlayerInspectedKeycardEventArgs ev)
		{
		}

		public virtual void OnPlayerSpinningRevolver(global::LabApi.Events.Arguments.PlayerEvents.PlayerSpinningRevolverEventArgs ev)
		{
		}

		public virtual void OnPlayerSpinnedRevolver(global::LabApi.Events.Arguments.PlayerEvents.PlayerSpinnedRevolverEventArgs ev)
		{
		}

		public virtual void OnPlayerToggledDisruptorFiringMode(global::LabApi.Events.Arguments.PlayerEvents.PlayerToggledDisruptorFiringModeEventArgs ev)
		{
		}

		public virtual void OnPlayerInspectingItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerInspectingItemEventArgs ev)
		{
		}

		public virtual void OnPlayerInspectedItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerInspectedItemEventArgs ev)
		{
		}

		public virtual void OnPlayerUsingItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerUsingItemEventArgs ev)
		{
		}

		public virtual void OnPlayerUsedItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerUsedItemEventArgs ev)
		{
		}

		public virtual void OnPlayerItemUsageEffectsApplying(global::LabApi.Events.Arguments.PlayerEvents.PlayerItemUsageEffectsApplyingEventArgs ev)
		{
		}

		public virtual void OnPlayerUsingRadio(global::LabApi.Events.Arguments.PlayerEvents.PlayerUsingRadioEventArgs ev)
		{
		}

		public virtual void OnPlayerUsedRadio(global::LabApi.Events.Arguments.PlayerEvents.PlayerUsedRadioEventArgs ev)
		{
		}

		public virtual void OnPlayerAimedWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerAimedWeaponEventArgs ev)
		{
		}

		public virtual void OnPlayerDryFiringWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerDryFiringWeaponEventArgs ev)
		{
		}

		public virtual void OnPlayerDryFiredWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerDryFiredWeaponEventArgs ev)
		{
		}

		public virtual void OnPlayerUnloadingWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnloadingWeaponEventArgs ev)
		{
		}

		public virtual void OnPlayerUnloadedWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnloadedWeaponEventArgs ev)
		{
		}

		public virtual void OnPlayerReloadingWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerReloadingWeaponEventArgs ev)
		{
		}

		public virtual void OnPlayerReloadedWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerReloadedWeaponEventArgs ev)
		{
		}

		public virtual void OnPlayerShootingWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerShootingWeaponEventArgs ev)
		{
		}

		public virtual void OnPlayerShotWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerShotWeaponEventArgs ev)
		{
		}

		public virtual void OnPlayerChangingAttachments(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingAttachmentsEventArgs ev)
		{
		}

		public virtual void OnPlayerChangedAttachments(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedAttachmentsEventArgs ev)
		{
		}

		public virtual void OnPlayerSendingAttachmentsPrefs(global::LabApi.Events.Arguments.PlayerEvents.PlayerSendingAttachmentsPrefsEventArgs ev)
		{
		}

		public virtual void OnPlayerSentAttachmentsPrefs(global::LabApi.Events.Arguments.PlayerEvents.PlayerSentAttachmentsPrefsEventArgs ev)
		{
		}

		public virtual void OnPlayerCancellingUsingItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerCancellingUsingItemEventArgs ev)
		{
		}

		public virtual void OnPlayerCancelledUsingItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerCancelledUsingItemEventArgs ev)
		{
		}

		public virtual void OnPlayerChangingRadioRange(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingRadioRangeEventArgs ev)
		{
		}

		public virtual void OnPlayerChangedRadioRange(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedRadioRangeEventArgs ev)
		{
		}

		public virtual void OnPlayerProcessingJailbirdMessage(global::LabApi.Events.Arguments.PlayerEvents.PlayerProcessingJailbirdMessageEventArgs ev)
		{
		}

		public virtual void OnPlayerProcessedJailbirdMessage(global::LabApi.Events.Arguments.PlayerEvents.PlayerProcessedJailbirdMessageEventArgs ev)
		{
		}

		public virtual void OnPlayerTogglingFlashlight(global::LabApi.Events.Arguments.PlayerEvents.PlayerTogglingFlashlightEventArgs ev)
		{
		}

		public virtual void OnPlayerToggledFlashlight(global::LabApi.Events.Arguments.PlayerEvents.PlayerToggledFlashlightEventArgs ev)
		{
		}

		public virtual void OnPlayerTogglingWeaponFlashlight(global::LabApi.Events.Arguments.PlayerEvents.PlayerTogglingWeaponFlashlightEventArgs ev)
		{
		}

		public virtual void OnPlayerToggledWeaponFlashlight(global::LabApi.Events.Arguments.PlayerEvents.PlayerToggledWeaponFlashlightEventArgs ev)
		{
		}

		public virtual void OnPlayerTogglingRadio(global::LabApi.Events.Arguments.PlayerEvents.PlayerTogglingRadioEventArgs ev)
		{
		}

		public virtual void OnPlayerToggledRadio(global::LabApi.Events.Arguments.PlayerEvents.PlayerToggledRadioEventArgs ev)
		{
		}

		public virtual void OnPlayerJumped(global::LabApi.Events.Arguments.PlayerEvents.PlayerJumpedEventArgs ev)
		{
		}

		public virtual void OnPlayerMovementStateChanged(global::LabApi.Events.Arguments.PlayerEvents.PlayerMovementStateChangedEventArgs ev)
		{
		}

		public virtual void OnPlayerProcessingScp1509Message(global::LabApi.Events.Arguments.PlayerEvents.PlayerProcessingScp1509MessageEventArgs ev)
		{
		}

		public virtual void OnPlayerProcessedScp1509Message(global::LabApi.Events.Arguments.PlayerEvents.PlayerProcessedScp1509MessageEventArgs ev)
		{
		}

		public virtual void OnPlayerScp1509Resurrecting(global::LabApi.Events.Arguments.PlayerEvents.PlayerScp1509ResurrectingEventArgs ev)
		{
		}

		public virtual void OnPlayerScp1509Resurrected(global::LabApi.Events.Arguments.PlayerEvents.PlayerScp1509ResurrectedEventArgs ev)
		{
		}

		public virtual void OnPlayerDamagingShootingTarget(global::LabApi.Events.Arguments.PlayerEvents.PlayerDamagingShootingTargetEventArgs ev)
		{
		}

		public virtual void OnPlayerDamagedShootingTarget(global::LabApi.Events.Arguments.PlayerEvents.PlayerDamagedShootingTargetEventArgs ev)
		{
		}

		public virtual void OnPlayerDamagingWindow(global::LabApi.Events.Arguments.PlayerEvents.PlayerDamagingWindowEventArgs ev)
		{
		}

		public virtual void OnPlayerDamagedWindow(global::LabApi.Events.Arguments.PlayerEvents.PlayerDamagedWindowEventArgs ev)
		{
		}

		public virtual void OnPlayerEnteringPocketDimension(global::LabApi.Events.Arguments.PlayerEvents.PlayerEnteringPocketDimensionEventArgs ev)
		{
		}

		public virtual void OnPlayerEnteredPocketDimension(global::LabApi.Events.Arguments.PlayerEvents.PlayerEnteredPocketDimensionEventArgs ev)
		{
		}

		public virtual void OnPlayerLeavingPocketDimension(global::LabApi.Events.Arguments.PlayerEvents.PlayerLeavingPocketDimensionEventArgs ev)
		{
		}

		public virtual void OnPlayerLeftPocketDimension(global::LabApi.Events.Arguments.PlayerEvents.PlayerLeftPocketDimensionEventArgs ev)
		{
		}

		public virtual void OnPlayerTriggeringTesla(global::LabApi.Events.Arguments.PlayerEvents.PlayerTriggeringTeslaEventArgs ev)
		{
		}

		public virtual void OnPlayerTriggeredTesla(global::LabApi.Events.Arguments.PlayerEvents.PlayerTriggeredTeslaEventArgs ev)
		{
		}

		public virtual void OnPlayerEscaping(global::LabApi.Events.Arguments.PlayerEvents.PlayerEscapingEventArgs ev)
		{
		}

		public virtual void OnPlayerEscaped(global::LabApi.Events.Arguments.PlayerEvents.PlayerEscapedEventArgs ev)
		{
		}

		public virtual void OnPlayerFlippingCoin(global::LabApi.Events.Arguments.PlayerEvents.PlayerFlippingCoinEventArgs ev)
		{
		}

		public virtual void OnPlayerFlippedCoin(global::LabApi.Events.Arguments.PlayerEvents.PlayerFlippedCoinEventArgs ev)
		{
		}

		public virtual void OnPlayerSearchingToy(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchingToyEventArgs ev)
		{
		}

		public virtual void OnPlayerSearchedToy(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchedToyEventArgs ev)
		{
		}

		public virtual void OnPlayerSearchToyAborted(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchToyAbortedEventArgs ev)
		{
		}

		public virtual void OnPlayerIdlingTesla(global::LabApi.Events.Arguments.PlayerEvents.PlayerIdlingTeslaEventArgs ev)
		{
		}

		public virtual void OnPlayerIdledTesla(global::LabApi.Events.Arguments.PlayerEvents.PlayerIdledTeslaEventArgs ev)
		{
		}

		public virtual void OnPlayerInteractingDoor(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingDoorEventArgs ev)
		{
		}

		public virtual void OnPlayerInteractedDoor(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedDoorEventArgs ev)
		{
		}

		public virtual void OnPlayerInteractingElevator(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingElevatorEventArgs ev)
		{
		}

		public virtual void OnPlayerInteractedElevator(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedElevatorEventArgs ev)
		{
		}

		public virtual void OnPlayerInteractingGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingGeneratorEventArgs ev)
		{
		}

		public virtual void OnPlayerInteractedGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedGeneratorEventArgs ev)
		{
		}

		public virtual void OnPlayerOpeningGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerOpeningGeneratorEventArgs ev)
		{
		}

		public virtual void OnPlayerOpenedGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerOpenedGeneratorEventArgs ev)
		{
		}

		public virtual void OnPlayerActivatingGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerActivatingGeneratorEventArgs ev)
		{
		}

		public virtual void OnPlayerActivatedGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerActivatedGeneratorEventArgs ev)
		{
		}

		public virtual void OnPlayerDeactivatingGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerDeactivatingGeneratorEventArgs ev)
		{
		}

		public virtual void OnPlayerDeactivatedGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerDeactivatedGeneratorEventArgs ev)
		{
		}

		public virtual void OnPlayerUnlockingGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnlockingGeneratorEventArgs ev)
		{
		}

		public virtual void OnPlayerUnlockedGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnlockedGeneratorEventArgs ev)
		{
		}

		public virtual void OnPlayerClosingGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerClosingGeneratorEventArgs ev)
		{
		}

		public virtual void OnPlayerClosedGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerClosedGeneratorEventArgs ev)
		{
		}

		public virtual void OnPlayerInteractingLocker(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingLockerEventArgs ev)
		{
		}

		public virtual void OnPlayerInteractedLocker(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedLockerEventArgs ev)
		{
		}

		public virtual void OnPlayerInteractingScp330(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingScp330EventArgs ev)
		{
		}

		public virtual void OnPlayerInteractedScp330(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedScp330EventArgs ev)
		{
		}

		public virtual void OnPlayerInteractingShootingTarget(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingShootingTargetEventArgs ev)
		{
		}

		public virtual void OnPlayerInteractedShootingTarget(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedShootingTargetEventArgs ev)
		{
		}

		public virtual void OnPlayerPlacingBlood(global::LabApi.Events.Arguments.PlayerEvents.PlayerPlacingBloodEventArgs ev)
		{
		}

		public virtual void OnPlayerPlacedBlood(global::LabApi.Events.Arguments.PlayerEvents.PlayerPlacedBloodEventArgs ev)
		{
		}

		public virtual void OnPlayerPlacingBulletHole(global::LabApi.Events.Arguments.PlayerEvents.PlayerPlacingBulletHoleEventArgs ev)
		{
		}

		public virtual void OnPlayerPlacedBulletHole(global::LabApi.Events.Arguments.PlayerEvents.PlayerPlacedBulletHoleEventArgs ev)
		{
		}

		public virtual void OnPlayerSpawningRagdoll(global::LabApi.Events.Arguments.PlayerEvents.PlayerSpawningRagdollEventArgs ev)
		{
		}

		public virtual void OnPlayerSpawnedRagdoll(global::LabApi.Events.Arguments.PlayerEvents.PlayerSpawnedRagdollEventArgs ev)
		{
		}

		public virtual void OnPlayerUnlockingWarheadButton(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnlockingWarheadButtonEventArgs ev)
		{
		}

		public virtual void OnPlayerUnlockedWarheadButton(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnlockedWarheadButtonEventArgs ev)
		{
		}

		public virtual void OnPlayerReceivedAchievement(global::LabApi.Events.Arguments.PlayerEvents.PlayerReceivedAchievementEventArgs ev)
		{
		}

		public virtual void OnPlayerRoomChanged(global::LabApi.Events.Arguments.PlayerEvents.PlayerRoomChangedEventArgs ev)
		{
		}

		public virtual void OnPlayerZoneChanged(global::LabApi.Events.Arguments.PlayerEvents.PlayerZoneChangedEventArgs ev)
		{
		}

		public virtual void OnPlayerInteractingWarheadLever(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingWarheadLeverEventArgs ev)
		{
		}

		public virtual void OnPlayerInteractedWarheadLever(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedWarheadLeverEventArgs ev)
		{
		}

		public virtual void OnPlayerSendingHitmarker(global::LabApi.Events.Arguments.PlayerEvents.PlayerSendingHitmarkerEventArgs ev)
		{
		}

		public virtual void OnPlayerSentHitmarker(global::LabApi.Events.Arguments.PlayerEvents.PlayerSentHitmarkerEventArgs ev)
		{
		}

		public virtual void OnPlayerCheckedHitmarker(global::LabApi.Events.Arguments.PlayerEvents.PlayerCheckedHitmarkerEventArgs ev)
		{
		}

		public virtual void OnPlayerChangedSpectator(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedSpectatorEventArgs ev)
		{
		}

		public virtual void OnPlayerEnteringHazard(global::LabApi.Events.Arguments.PlayerEvents.PlayerEnteringHazardEventArgs ev)
		{
		}

		public virtual void OnPlayerEnteredHazard(global::LabApi.Events.Arguments.PlayerEvents.PlayerEnteredHazardEventArgs ev)
		{
		}

		public virtual void OnPlayerStayingInHazard(global::LabApi.Events.Arguments.PlayerEvents.PlayersStayingInHazardEventArgs ev)
		{
		}

		public virtual void OnPlayerLeavingHazard(global::LabApi.Events.Arguments.PlayerEvents.PlayerLeavingHazardEventArgs ev)
		{
		}

		public virtual void OnPlayerLeftHazard(global::LabApi.Events.Arguments.PlayerEvents.PlayerLeftHazardEventArgs ev)
		{
		}

		public virtual void OnPlayerValidatedVisibility(global::LabApi.Events.Arguments.PlayerEvents.PlayerValidatedVisibilityEventArgs ev)
		{
		}

		public virtual void OnPlayerDetectedByScp1344(global::LabApi.Events.Arguments.PlayerEvents.PlayerDetectedByScp1344EventArgs ev)
		{
		}

		public virtual void OnScp0492StartingConsumingCorpse(global::LabApi.Events.Arguments.Scp0492Events.Scp0492StartingConsumingCorpseEventArgs ev)
		{
		}

		public virtual void OnScp0492StartedConsumingCorpse(global::LabApi.Events.Arguments.Scp0492Events.Scp0492StartedConsumingCorpseEventArgs ev)
		{
		}

		public virtual void OnScp0492ConsumingCorpse(global::LabApi.Events.Arguments.Scp0492Events.Scp0492ConsumingCorpseEventArgs ev)
		{
		}

		public virtual void OnScp0492ConsumedCorpse(global::LabApi.Events.Arguments.Scp0492Events.Scp0492ConsumedCorpseEventArgs ev)
		{
		}

		public virtual void OnScp049StartingResurrection(global::LabApi.Events.Arguments.Scp049Events.Scp049StartingResurrectionEventArgs ev)
		{
		}

		public virtual void OnScp049ResurrectingBody(global::LabApi.Events.Arguments.Scp049Events.Scp049ResurrectingBodyEventArgs ev)
		{
		}

		public virtual void OnScp049ResurrectedBody(global::LabApi.Events.Arguments.Scp049Events.Scp049ResurrectedBodyEventArgs ev)
		{
		}

		public virtual void OnScp049UsingDoctorsCall(global::LabApi.Events.Arguments.Scp049Events.Scp049UsingDoctorsCallEventArgs ev)
		{
		}

		public virtual void OnScp049UsedDoctorsCall(global::LabApi.Events.Arguments.Scp049Events.Scp049UsedDoctorsCallEventArgs ev)
		{
		}

		public virtual void OnScp049UsingSense(global::LabApi.Events.Arguments.Scp049Events.Scp049UsingSenseEventArgs ev)
		{
		}

		public virtual void OnScp049UsedSense(global::LabApi.Events.Arguments.Scp049Events.Scp049UsedSenseEventArgs ev)
		{
		}

		public virtual void OnScp049Attacking(global::LabApi.Events.Arguments.Scp049Events.Scp049AttackingEventArgs ev)
		{
		}

		public virtual void OnScp049Attacked(global::LabApi.Events.Arguments.Scp049Events.Scp049AttackedEventArgs ev)
		{
		}

		public virtual void OnScp049SenseLostTarget(global::LabApi.Events.Arguments.Scp049Events.Scp049SenseLostTargetEventArgs ev)
		{
		}

		public virtual void OnScp049SenseKilledTarget(global::LabApi.Events.Arguments.Scp049Events.Scp049SenseKilledTargetEventArgs ev)
		{
		}

		public virtual void OnScp079BlackingOutRoom(global::LabApi.Events.Arguments.Scp079Events.Scp079BlackingOutRoomEventsArgs ev)
		{
		}

		public virtual void OnScp079BlackedOutRoom(global::LabApi.Events.Arguments.Scp079Events.Scp079BlackedOutRoomEventArgs ev)
		{
		}

		public virtual void OnScp079BlackingOutZone(global::LabApi.Events.Arguments.Scp079Events.Scp079BlackingOutZoneEventArgs ev)
		{
		}

		public virtual void OnScp079BlackedOutZone(global::LabApi.Events.Arguments.Scp079Events.Scp079BlackedOutZoneEventArgs ev)
		{
		}

		public virtual void OnScp079ChangingCamera(global::LabApi.Events.Arguments.Scp079Events.Scp079ChangingCameraEventArgs ev)
		{
		}

		public virtual void OnScp079ChangedCamera(global::LabApi.Events.Arguments.Scp079Events.Scp079ChangedCameraEventArgs ev)
		{
		}

		public virtual void OnScp079CancellingRoomLockdown(global::LabApi.Events.Arguments.Scp079Events.Scp079CancellingRoomLockdownEventArgs ev)
		{
		}

		public virtual void OnScp079CancelledRoomLockdown(global::LabApi.Events.Arguments.Scp079Events.Scp079CancelledRoomLockdownEventArgs ev)
		{
		}

		public virtual void OnScp079GainingExperience(global::LabApi.Events.Arguments.Scp079Events.Scp079GainingExperienceEventArgs ev)
		{
		}

		public virtual void OnScp079GainedExperience(global::LabApi.Events.Arguments.Scp079Events.Scp079GainedExperienceEventArgs ev)
		{
		}

		public virtual void OnScp079LevelingUp(global::LabApi.Events.Arguments.Scp079Events.Scp079LevelingUpEventArgs ev)
		{
		}

		public virtual void OnScp079LeveledUp(global::LabApi.Events.Arguments.Scp079Events.Scp079LeveledUpEventArgs ev)
		{
		}

		public virtual void OnScp079LockingDoor(global::LabApi.Events.Arguments.Scp079Events.Scp079LockingDoorEventArgs ev)
		{
		}

		public virtual void OnScp079LockedDoor(global::LabApi.Events.Arguments.Scp079Events.Scp079LockedDoorEventArgs ev)
		{
		}

		public virtual void OnScp079LockingDownRoom(global::LabApi.Events.Arguments.Scp079Events.Scp079LockingDownRoomEventArgs ev)
		{
		}

		public virtual void OnScp079LockedDownRoom(global::LabApi.Events.Arguments.Scp079Events.Scp079LockedDownRoomEventArgs ev)
		{
		}

		public virtual void OnScp079Recontaining(global::LabApi.Events.Arguments.Scp079Events.Scp079RecontainingEventArgs ev)
		{
		}

		public virtual void OnScp079Recontained(global::LabApi.Events.Arguments.Scp079Events.Scp079RecontainedEventArgs ev)
		{
		}

		public virtual void OnScp079UnlockingDoor(global::LabApi.Events.Arguments.Scp079Events.Scp079UnlockingDoorEventArgs ev)
		{
		}

		public virtual void OnScp079UnlockedDoor(global::LabApi.Events.Arguments.Scp079Events.Scp079UnlockedDoorEventArgs ev)
		{
		}

		public virtual void OnScp079UsingTesla(global::LabApi.Events.Arguments.Scp079Events.Scp079UsingTeslaEventArgs ev)
		{
		}

		public virtual void OnScp079UsedTesla(global::LabApi.Events.Arguments.Scp079Events.Scp079UsedTeslaEventArgs ev)
		{
		}

		public virtual void OnScp079Pinging(global::LabApi.Events.Arguments.Scp079Events.Scp079PingingEventArgs ev)
		{
		}

		public virtual void OnScp079Pinged(global::LabApi.Events.Arguments.Scp079Events.Scp079PingedEventArgs ev)
		{
		}

		public virtual void OnScp096AddingTarget(global::LabApi.Events.Arguments.Scp096Events.Scp096AddingTargetEventArgs ev)
		{
		}

		public virtual void OnScp096AddedTarget(global::LabApi.Events.Arguments.Scp096Events.Scp096AddedTargetEventArgs ev)
		{
		}

		public virtual void OnScp096ChangingState(global::LabApi.Events.Arguments.Scp096Events.Scp096ChangingStateEventArgs ev)
		{
		}

		public virtual void OnScp096ChangedState(global::LabApi.Events.Arguments.Scp096Events.Scp096ChangedStateEventArgs ev)
		{
		}

		public virtual void OnScp096Charging(global::LabApi.Events.Arguments.Scp096Events.Scp096ChargingEventArgs ev)
		{
		}

		public virtual void OnScp096Charged(global::LabApi.Events.Arguments.Scp096Events.Scp096ChargedEventArgs ev)
		{
		}

		public virtual void OnScp096Enraging(global::LabApi.Events.Arguments.Scp096Events.Scp096EnragingEventArgs ev)
		{
		}

		public virtual void OnScp096Enraged(global::LabApi.Events.Arguments.Scp096Events.Scp096EnragedEventArgs ev)
		{
		}

		public virtual void OnScp096PryingGate(global::LabApi.Events.Arguments.Scp096Events.Scp096PryingGateEventArgs ev)
		{
		}

		public virtual void OnScp096PriedGate(global::LabApi.Events.Arguments.Scp096Events.Scp096PriedGateEventArgs ev)
		{
		}

		public virtual void OnScp096StartCrying(global::LabApi.Events.Arguments.Scp096Events.Scp096StartCryingEventArgs ev)
		{
		}

		public virtual void OnScp096StartedCrying(global::LabApi.Events.Arguments.Scp096Events.Scp096StartedCryingEventArgs ev)
		{
		}

		public virtual void OnScp096TryingNotToCry(global::LabApi.Events.Arguments.Scp096Events.Scp096TryingNotToCryEventArgs ev)
		{
		}

		public virtual void OnScp096TriedNotToCry(global::LabApi.Events.Arguments.Scp096Events.Scp096TriedNotToCryEventArgs ev)
		{
		}

		public virtual void OnScp106ChangingStalkMode(global::LabApi.Events.Arguments.Scp106Events.Scp106ChangingStalkModeEventArgs ev)
		{
		}

		public virtual void OnScp106ChangedStalkMode(global::LabApi.Events.Arguments.Scp106Events.Scp106ChangedStalkModeEventArgs ev)
		{
		}

		public virtual void OnScp106ChangingVigor(global::LabApi.Events.Arguments.Scp106Events.Scp106ChangingVigorEventArgs ev)
		{
		}

		public virtual void OnScp106ChangedVigor(global::LabApi.Events.Arguments.Scp106Events.Scp106ChangedVigorEventArgs ev)
		{
		}

		public virtual void OnScp106UsedHunterAtlas(global::LabApi.Events.Arguments.Scp106Events.Scp106UsedHunterAtlasEventArgs ev)
		{
		}

		public virtual void OnScp106UsingHunterAtlas(global::LabApi.Events.Arguments.Scp106Events.Scp106UsingHunterAtlasEventArgs ev)
		{
		}

		public virtual void OnScp106ChangingSubmersionStatus(global::LabApi.Events.Arguments.Scp106Events.Scp106ChangingSubmersionStatusEventArgs ev)
		{
		}

		public virtual void OnScp106ChangedSubmersionStatus(global::LabApi.Events.Arguments.Scp106Events.Scp106ChangedSubmersionStatusEventArgs ev)
		{
		}

		public virtual void OnScp106TeleportingPlayer(global::LabApi.Events.Arguments.Scp106Events.Scp106TeleportingPlayerEvent ev)
		{
		}

		public virtual void OnScp106TeleportedPlayer(global::LabApi.Events.Arguments.Scp106Events.Scp106TeleportedPlayerEvent ev)
		{
		}

		public virtual void OnScp127GainingExperience(global::LabApi.Events.Arguments.Scp127Events.Scp127GainingExperienceEventArgs ev)
		{
		}

		public virtual void OnScp127GainExperience(global::LabApi.Events.Arguments.Scp127Events.Scp127GainExperienceEventArgs ev)
		{
		}

		public virtual void OnScp127LevellingUp(global::LabApi.Events.Arguments.Scp127Events.Scp127LevellingUpEventArgs ev)
		{
		}

		public virtual void OnScp127LevelUp(global::LabApi.Events.Arguments.Scp127Events.Scp127LevelUpEventArgs ev)
		{
		}

		public virtual void OnScp127Talking(global::LabApi.Events.Arguments.Scp127Events.Scp127TalkingEventArgs ev)
		{
		}

		public virtual void OnScp127Talked(global::LabApi.Events.Arguments.Scp127Events.Scp127TalkedEventArgs ev)
		{
		}

		public virtual void OnScp173BreakneckSpeedChanging(global::LabApi.Events.Arguments.Scp173Events.Scp173BreakneckSpeedChangingEventArgs ev)
		{
		}

		public virtual void OnScp173BreakneckSpeedChanged(global::LabApi.Events.Arguments.Scp173Events.Scp173BreakneckSpeedChangedEventArgs ev)
		{
		}

		public virtual void OnScp173AddingObserver(global::LabApi.Events.Arguments.Scp173Events.Scp173AddingObserverEventArgs ev)
		{
		}

		public virtual void OnScp173AddedObserver(global::LabApi.Events.Arguments.Scp173Events.Scp173AddedObserverEventArgs ev)
		{
		}

		public virtual void OnScp173RemovingObserver(global::LabApi.Events.Arguments.Scp173Events.Scp173RemovingObserverEventArgs ev)
		{
		}

		public virtual void OnScp173RemovedObserver(global::LabApi.Events.Arguments.Scp173Events.Scp173RemovedObserverEventArgs ev)
		{
		}

		public virtual void OnScp173CreatingTantrum(global::LabApi.Events.Arguments.Scp173Events.Scp173CreatingTantrumEventArgs ev)
		{
		}

		public virtual void OnScp173CreatedTantrum(global::LabApi.Events.Arguments.Scp173Events.Scp173CreatedTantrumEventArgs ev)
		{
		}

		public virtual void OnScp173PlayingSound(global::LabApi.Events.Arguments.Scp173Events.Scp173PlayingSoundEventArgs ev)
		{
		}

		public virtual void OnScp173PlayedSound(global::LabApi.Events.Arguments.Scp173Events.Scp173PlayedSoundEventArgs ev)
		{
		}

		public virtual void OnScp173Teleporting(global::LabApi.Events.Arguments.Scp173Events.Scp173TeleportingEventArgs ev)
		{
		}

		public virtual void OnScp173Teleported(global::LabApi.Events.Arguments.Scp173Events.Scp173TeleportedEventArgs ev)
		{
		}

		public virtual void OnScp173Snapping(global::LabApi.Events.Arguments.Scp173Events.Scp173SnappingEventArgs ev)
		{
		}

		public virtual void OnScp173Snapped(global::LabApi.Events.Arguments.Scp173Events.Scp173SnappedEventArgs ev)
		{
		}

		public virtual void OnScp3114Disguising(global::LabApi.Events.Arguments.Scp3114Events.Scp3114DisguisingEventArgs ev)
		{
		}

		public virtual void OnScp3114Disguised(global::LabApi.Events.Arguments.Scp3114Events.Scp3114DisguisedEventArgs ev)
		{
		}

		public virtual void OnScp3114Revealing(global::LabApi.Events.Arguments.Scp3114Events.Scp3114RevealingEventArgs ev)
		{
		}

		public virtual void OnScp3114Revealed(global::LabApi.Events.Arguments.Scp3114Events.Scp3114RevealedEventArgs ev)
		{
		}

		public virtual void OnScp3114StrangleStarting(global::LabApi.Events.Arguments.Scp3114Events.Scp3114StrangleStartingEventArgs ev)
		{
		}

		public virtual void OnScp3114StrangleStarted(global::LabApi.Events.Arguments.Scp3114Events.Scp3114StrangleStartedEventArgs ev)
		{
		}

		public virtual void OnScp3114StrangleAborting(global::LabApi.Events.Arguments.Scp3114Events.Scp3114StrangleAbortingEventArgs ev)
		{
		}

		public virtual void OnScp3114Dance(global::LabApi.Events.Arguments.Scp3114Events.Scp3114StartedDanceEventArgs ev)
		{
		}

		public virtual void OnScp3114StartDancing(global::LabApi.Events.Arguments.Scp3114Events.Scp3114StartingDanceEventArgs ev)
		{
		}

		public virtual void OnScp3114StrangleAborted(global::LabApi.Events.Arguments.Scp3114Events.Scp3114StrangleAbortedEventArgs ev)
		{
		}

		public virtual void OnScp914Activating(global::LabApi.Events.Arguments.Scp914Events.Scp914ActivatingEventArgs ev)
		{
		}

		public virtual void OnScp914Activated(global::LabApi.Events.Arguments.Scp914Events.Scp914ActivatedEventArgs ev)
		{
		}

		public virtual void OnScp914KnobChanging(global::LabApi.Events.Arguments.Scp914Events.Scp914KnobChangingEventArgs ev)
		{
		}

		public virtual void OnScp914KnobChanged(global::LabApi.Events.Arguments.Scp914Events.Scp914KnobChangedEventArgs ev)
		{
		}

		public virtual void OnScp914ProcessingPickup(global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessingPickupEventArgs ev)
		{
		}

		public virtual void OnScp914ProcessedPickup(global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessedPickupEventArgs ev)
		{
		}

		public virtual void OnScp914ProcessingPlayer(global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessingPlayerEventArgs ev)
		{
		}

		public virtual void OnScp914ProcessedPlayer(global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessedPlayerEventArgs ev)
		{
		}

		public virtual void OnScp914ProcessingInventoryItem(global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessingInventoryItemEventArgs ev)
		{
		}

		public virtual void OnScp914ProcessedInventoryItem(global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessedInventoryItemEventArgs ev)
		{
		}

		public virtual void OnScp939Attacking(global::LabApi.Events.Arguments.Scp939Events.Scp939AttackingEventArgs ev)
		{
		}

		public virtual void OnScp939Attacked(global::LabApi.Events.Arguments.Scp939Events.Scp939AttackedEventArgs ev)
		{
		}

		public virtual void OnScp939CreatingAmnesticCloud(global::LabApi.Events.Arguments.Scp939Events.Scp939CreatingAmnesticCloudEventArgs ev)
		{
		}

		public virtual void OnScp939CreatedAmnesticCloud(global::LabApi.Events.Arguments.Scp939Events.Scp939CreatedAmnesticCloudEventArgs ev)
		{
		}

		public virtual void OnScp939Lunging(global::LabApi.Events.Arguments.Scp939Events.Scp939LungingEventArgs ev)
		{
		}

		public virtual void OnScp939Lunged(global::LabApi.Events.Arguments.Scp939Events.Scp939LungedEventArgs ev)
		{
		}

		public virtual void OnScp939Focused(global::LabApi.Events.Arguments.Scp939Events.Scp939FocusedEventArgs ev)
		{
		}

		public virtual void OnScp939MimickingEnvironment(global::LabApi.Events.Arguments.Scp939Events.Scp939MimickingEnvironmentEventArgs ev)
		{
		}

		public virtual void OnScp939MimickedEnvironment(global::LabApi.Events.Arguments.Scp939Events.Scp939MimickedEnvironmentEventArgs ev)
		{
		}

		public virtual void OnScpHumeShieldBroken(global::LabApi.Events.Arguments.ScpEvents.ScpHumeShieldBrokenEventArgs ev)
		{
		}

		public virtual void OnServerWaitingForPlayers()
		{
		}

		public virtual void OnServerRoundRestarted()
		{
		}

		public virtual void OnServerShutdown()
		{
		}

		public virtual void OnServerDeadmanSequenceActivated()
		{
		}

		public virtual void OnServerDeadmanSequenceActivating(global::LabApi.Events.Arguments.ServerEvents.DeadmanSequenceActivatingEventArgs ev)
		{
		}

		public virtual void OnServerRoundEndingConditionsCheck(global::LabApi.Events.Arguments.ServerEvents.RoundEndingConditionsCheckEventArgs ev)
		{
		}

		public virtual void OnServerRoundEnding(global::LabApi.Events.Arguments.ServerEvents.RoundEndingEventArgs ev)
		{
		}

		public virtual void OnServerRoundEnded(global::LabApi.Events.Arguments.ServerEvents.RoundEndedEventArgs ev)
		{
		}

		public virtual void OnServerRoundStarting(global::LabApi.Events.Arguments.ServerEvents.RoundStartingEventArgs ev)
		{
		}

		public virtual void OnServerRoundStarted()
		{
		}

		public virtual void OnServerBanIssuing(global::LabApi.Events.Arguments.ServerEvents.BanIssuingEventArgs ev)
		{
		}

		public virtual void OnServerBanIssued(global::LabApi.Events.Arguments.ServerEvents.BanIssuedEventArgs ev)
		{
		}

		public virtual void OnServerBanRevoking(global::LabApi.Events.Arguments.ServerEvents.BanRevokingEventArgs ev)
		{
		}

		public virtual void OnServerBanRevoked(global::LabApi.Events.Arguments.ServerEvents.BanRevokedEventArgs ev)
		{
		}

		public virtual void OnServerBanUpdating(global::LabApi.Events.Arguments.ServerEvents.BanUpdatingEventArgs ev)
		{
		}

		public virtual void OnServerBanUpdated(global::LabApi.Events.Arguments.ServerEvents.BanUpdatedEventArgs ev)
		{
		}

		public virtual void OnServerCommandExecuting(global::LabApi.Events.Arguments.ServerEvents.CommandExecutingEventArgs ev)
		{
		}

		public virtual void OnServerCommandExecuted(global::LabApi.Events.Arguments.ServerEvents.CommandExecutedEventArgs ev)
		{
		}

		public virtual void OnServerCassieQueuingScpTermination(global::LabApi.Events.Arguments.ServerEvents.CassieQueuingScpTerminationEventArgs ev)
		{
		}

		public virtual void OnServerCassieQueuedScpTermination(global::LabApi.Events.Arguments.ServerEvents.CassieQueuedScpTerminationEventArgs ev)
		{
		}

		public virtual void OnServerWaveRespawning(global::LabApi.Events.Arguments.ServerEvents.WaveRespawningEventArgs ev)
		{
		}

		public virtual void OnServerWaveRespawned(global::LabApi.Events.Arguments.ServerEvents.WaveRespawnedEventArgs ev)
		{
		}

		public virtual void OnServerWaveTeamSelecting(global::LabApi.Events.Arguments.ServerEvents.WaveTeamSelectingEventArgs ev)
		{
		}

		public virtual void OnServerWaveTeamSelected(global::LabApi.Events.Arguments.ServerEvents.WaveTeamSelectedEventArgs ev)
		{
		}

		public virtual void OnServerLczDecontaminationAnnounced(global::LabApi.Events.Arguments.ServerEvents.LczDecontaminationAnnouncedEventArgs ev)
		{
		}

		public virtual void OnServerLczDecontaminationStarting(global::LabApi.Events.Arguments.ServerEvents.LczDecontaminationStartingEventArgs ev)
		{
		}

		public virtual void OnServerLczDecontaminationStarted()
		{
		}

		public virtual void OnServerMapGenerating(global::LabApi.Events.Arguments.ServerEvents.MapGeneratingEventArgs ev)
		{
		}

		public virtual void OnServerMapGenerated(global::LabApi.Events.Arguments.ServerEvents.MapGeneratedEventArgs ev)
		{
		}

		public virtual void OnServerPickupCreated(global::LabApi.Events.Arguments.ServerEvents.PickupCreatedEventArgs ev)
		{
		}

		public virtual void OnServerPickupDestroyed(global::LabApi.Events.Arguments.ServerEvents.PickupDestroyedEventArgs ev)
		{
		}

		public virtual void OnServerSendingAdminChat(global::LabApi.Events.Arguments.ServerEvents.SendingAdminChatEventArgs ev)
		{
		}

		public virtual void OnServerSentAdminChat(global::LabApi.Events.Arguments.ServerEvents.SentAdminChatEventArgs ev)
		{
		}

		public virtual void OnServerItemSpawning(global::LabApi.Events.Arguments.ServerEvents.ItemSpawningEventArgs ev)
		{
		}

		public virtual void OnServerItemSpawned(global::LabApi.Events.Arguments.ServerEvents.ItemSpawnedEventArgs ev)
		{
		}

		public virtual void OnServerCassieAnnouncing(global::LabApi.Events.Arguments.ServerEvents.CassieAnnouncingEventArgs ev)
		{
		}

		public virtual void OnServerCassieAnnounced(global::LabApi.Events.Arguments.ServerEvents.CassieAnnouncedEventArgs ev)
		{
		}

		public virtual void OnServerProjectileExploding(global::LabApi.Events.Arguments.ServerEvents.ProjectileExplodingEventArgs ev)
		{
		}

		public virtual void OnServerProjectileExploded(global::LabApi.Events.Arguments.ServerEvents.ProjectileExplodedEventArgs ev)
		{
		}

		public virtual void OnServerExplosionSpawning(global::LabApi.Events.Arguments.ServerEvents.ExplosionSpawningEventArgs ev)
		{
		}

		public virtual void OnServerExplosionSpawned(global::LabApi.Events.Arguments.ServerEvents.ExplosionSpawnedEventArgs ev)
		{
		}

		public virtual void OnServerGeneratorActivating(global::LabApi.Events.Arguments.ServerEvents.GeneratorActivatingEventArgs ev)
		{
		}

		public virtual void OnServerGeneratorActivated(global::LabApi.Events.Arguments.ServerEvents.GeneratorActivatedEventArgs ev)
		{
		}

		public virtual void OnServerElevatorSequenceChanged(global::LabApi.Events.Arguments.ServerEvents.ElevatorSequenceChangedEventArgs ev)
		{
		}

		public virtual void OnServerModifyingFactionInfluence(global::LabApi.Events.Arguments.ServerEvents.ModifyingFactionInfluenceEventArgs ev)
		{
		}

		public virtual void OnServerModifiedFactionInfluence(global::LabApi.Events.Arguments.ServerEvents.ModifiedFactionInfluenceEventArgs ev)
		{
		}

		public virtual void OnServerAchievingMilestone(global::LabApi.Events.Arguments.ServerEvents.AchievingMilestoneEventArgs ev)
		{
		}

		public virtual void OnServerAchievedMilestone(global::LabApi.Events.Arguments.ServerEvents.AchievedMilestoneEventArgs ev)
		{
		}

		public virtual void OnServerBlastDoorChanging(global::LabApi.Events.Arguments.ServerEvents.BlastDoorChangingEventArgs ev)
		{
		}

		public virtual void OnServerBlastDoorChanged(global::LabApi.Events.Arguments.ServerEvents.BlastDoorChangedEventArgs ev)
		{
		}

		public virtual void OnServerRoomLightChanged(global::LabApi.Events.Arguments.ServerEvents.RoomLightChangedEventArgs ev)
		{
		}

		public virtual void OnServerRoomColorChanged(global::LabApi.Events.Arguments.ServerEvents.RoomColorChangedEventArgs ev)
		{
		}

		public virtual void OnServerDoorLockChanged(global::LabApi.Events.Arguments.ServerEvents.DoorLockChangedEventArgs ev)
		{
		}

		public virtual void OnServerDoorRepairing(global::LabApi.Events.Arguments.ServerEvents.DoorRepairingEventArgs ev)
		{
		}

		public virtual void OnServerDoorRepaired(global::LabApi.Events.Arguments.ServerEvents.DoorRepairedEventArgs ev)
		{
		}

		public virtual void OnServerDoorDamaging(global::LabApi.Events.Arguments.ServerEvents.DoorDamagingEventArgs ev)
		{
		}

		public virtual void OnServerDoorDamaged(global::LabApi.Events.Arguments.ServerEvents.DoorDamagedEventArgs ev)
		{
		}

		public virtual void OnServerCheckpointDoorSequenceChanging(global::LabApi.Events.Arguments.ServerEvents.CheckpointDoorSequenceChangingEventArgs ev)
		{
		}

		public virtual void OnServerCheckpointDoorSequenceChanged(global::LabApi.Events.Arguments.ServerEvents.CheckpointDoorSequenceChangedEventArgs ev)
		{
		}

		public virtual void OnServerPluginsEnabled()
		{
		}

		public virtual void OnWarheadStarting(global::LabApi.Events.Arguments.WarheadEvents.WarheadStartingEventArgs ev)
		{
		}

		public virtual void OnWarheadStarted(global::LabApi.Events.Arguments.WarheadEvents.WarheadStartedEventArgs ev)
		{
		}

		public virtual void OnWarheadStopping(global::LabApi.Events.Arguments.WarheadEvents.WarheadStoppingEventArgs ev)
		{
		}

		public virtual void OnWarheadStopped(global::LabApi.Events.Arguments.WarheadEvents.WarheadStoppedEventArgs ev)
		{
		}

		public virtual void OnWarheadDetonating(global::LabApi.Events.Arguments.WarheadEvents.WarheadDetonatingEventArgs ev)
		{
		}

		public virtual void OnWarheadDetonated(global::LabApi.Events.Arguments.WarheadEvents.WarheadDetonatedEventArgs ev)
		{
		}
	}
}
