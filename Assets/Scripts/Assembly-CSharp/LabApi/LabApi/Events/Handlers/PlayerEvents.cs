namespace LabApi.Events.Handlers
{
	public static class PlayerEvents
	{
		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerJoinedEventArgs>? Joined;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerLeftEventArgs>? Left;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerReceivingVoiceMessageEventArgs>? ReceivingVoiceMessage;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSendingVoiceMessageEventArgs>? SendingVoiceMessage;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerPreAuthenticatingEventArgs>? PreAuthenticating;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerPreAuthenticatedEventArgs>? PreAuthenticated;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUsingIntercomEventArgs>? UsingIntercom;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUsedIntercomEventArgs>? UsedIntercom;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerBanningEventArgs>? Banning;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerBannedEventArgs>? Banned;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerKickingEventArgs>? Kicking;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerKickedEventArgs>? Kicked;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerMutingEventArgs>? Muting;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerMutedEventArgs>? Muted;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUnmutingEventArgs>? Unmuting;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUnmutedEventArgs>? Unmuted;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerReportingCheaterEventArgs>? ReportingCheater;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerReportedCheaterEventArgs>? ReportedCheater;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerReportingPlayerEventArgs>? ReportingPlayer;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerReportedPlayerEventArgs>? ReportedPlayer;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerTogglingNoclipEventArgs>? TogglingNoclip;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerToggledNoclipEventArgs>? ToggledNoclip;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestingRaPlayerListEventArgs>? RequestingRaPlayerList;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestedRaPlayerListEventArgs>? RequestedRaPlayerList;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerRaPlayerListAddingPlayerEventArgs>? RaPlayerListAddingPlayer;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerRaPlayerListAddedPlayerEventArgs>? RaPlayerListAddedPlayer;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestedCustomRaInfoEventArgs>? RequestedCustomRaInfo;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestingRaPlayersInfoEventArgs>? RequestingRaPlayersInfo;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestedRaPlayersInfoEventArgs>? RequestedRaPlayersInfo;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestingRaPlayerInfoEventArgs>? RequestingRaPlayerInfo;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestedRaPlayerInfoEventArgs>? RequestedRaPlayerInfo;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingBadgeVisibilityEventArgs>? ChangingBadgeVisibility;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedBadgeVisibilityEventArgs>? ChangedBadgeVisibility;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingNicknameEventArgs>? ChangingNickname;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedNicknameEventArgs>? ChangedNickname;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerGroupChangingEventArgs>? GroupChanging;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerGroupChangedEventArgs>? GroupChanged;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerEffectUpdatingEventArgs>? UpdatingEffect;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerEffectUpdatedEventArgs>? UpdatedEffect;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerDyingEventArgs>? Dying;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerDeathEventArgs>? Death;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerHurtingEventArgs>? Hurting;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerHurtEventArgs>? Hurt;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingRoleEventArgs>? ChangingRole;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedRoleEventArgs>? ChangedRole;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerCuffingEventArgs>? Cuffing;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerCuffedEventArgs>? Cuffed;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUncuffingEventArgs>? Uncuffing;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUncuffedEventArgs>? Uncuffed;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerReceivingLoadoutEventArgs>? ReceivingLoadout;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerReceivedLoadoutEventArgs>? ReceivedLoadout;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSpawningEventArgs>? Spawning;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSpawnedEventArgs>? Spawned;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingItemEventArgs>? ChangingItem;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedItemEventArgs>? ChangedItem;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerDroppingAmmoEventArgs>? DroppingAmmo;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerDroppedAmmoEventArgs>? DroppedAmmo;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerDroppingItemEventArgs>? DroppingItem;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerDroppedItemEventArgs>? DroppedItem;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerPickingUpAmmoEventArgs>? PickingUpAmmo;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerPickedUpAmmoEventArgs>? PickedUpAmmo;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerPickingUpArmorEventArgs>? PickingUpArmor;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerPickedUpArmorEventArgs>? PickedUpArmor;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerPickingUpItemEventArgs>? PickingUpItem;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerPickedUpItemEventArgs>? PickedUpItem;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerPickingUpScp330EventArgs>? PickingUpScp330;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerPickedUpScp330EventArgs>? PickedUpScp330;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchedAmmoEventArgs>? SearchedAmmo;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchingArmorEventArgs>? SearchingArmor;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchedArmorEventArgs>? SearchedArmor;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchingPickupEventArgs>? SearchingPickup;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedToyEventArgs>? InteractedToy;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchedPickupEventArgs>? SearchedPickup;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchingAmmoEventArgs>? SearchingAmmo;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerThrowingItemEventArgs>? ThrowingItem;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerThrewItemEventArgs>? ThrewItem;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerThrowingProjectileEventArgs>? ThrowingProjectile;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerThrewProjectileEventArgs>? ThrewProjectile;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInspectingKeycardEventArgs>? InspectingKeycard;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInspectedKeycardEventArgs>? InspectedKeycard;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSpinningRevolverEventArgs>? SpinningRevolver;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSpinnedRevolverEventArgs>? SpinnedRevolver;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerToggledDisruptorFiringModeEventArgs>? ToggledDisruptorFiringMode;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInspectingItemEventArgs>? InspectingItem;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInspectedItemEventArgs>? InspectedItem;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUsingItemEventArgs>? UsingItem;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUsedItemEventArgs>? UsedItem;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerItemUsageEffectsApplyingEventArgs>? ItemUsageEffectsApplying;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUsingRadioEventArgs>? UsingRadio;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUsedRadioEventArgs>? UsedRadio;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerAimedWeaponEventArgs>? AimedWeapon;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerDryFiringWeaponEventArgs>? DryFiringWeapon;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerDryFiredWeaponEventArgs>? DryFiredWeapon;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUnloadingWeaponEventArgs>? UnloadingWeapon;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUnloadedWeaponEventArgs>? UnloadedWeapon;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerReloadingWeaponEventArgs>? ReloadingWeapon;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerReloadedWeaponEventArgs>? ReloadedWeapon;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerShootingWeaponEventArgs>? ShootingWeapon;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerShotWeaponEventArgs>? ShotWeapon;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingAttachmentsEventArgs>? ChangingAttachments;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedAttachmentsEventArgs>? ChangedAttachments;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSendingAttachmentsPrefsEventArgs>? SendingAttachmentsPrefs;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSentAttachmentsPrefsEventArgs>? SentAttachmentsPrefs;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerCancellingUsingItemEventArgs>? CancellingUsingItem;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerCancelledUsingItemEventArgs>? CancelledUsingItem;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingRadioRangeEventArgs>? ChangingRadioRange;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedRadioRangeEventArgs>? ChangedRadioRange;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerProcessingJailbirdMessageEventArgs>? ProcessingJailbirdMessage;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerProcessedJailbirdMessageEventArgs>? ProcessedJailbirdMessage;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerTogglingFlashlightEventArgs>? TogglingFlashlight;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerToggledFlashlightEventArgs>? ToggledFlashlight;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerTogglingWeaponFlashlightEventArgs>? TogglingWeaponFlashlight;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerToggledWeaponFlashlightEventArgs>? ToggledWeaponFlashlight;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerTogglingRadioEventArgs>? TogglingRadio;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerToggledRadioEventArgs>? ToggledRadio;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerJumpedEventArgs>? Jumped;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerMovementStateChangedEventArgs>? MovementStateChanged;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerProcessingScp1509MessageEventArgs>? ProcessingScp1509Message;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerProcessedScp1509MessageEventArgs>? ProcessedScp1509Message;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerScp1509ResurrectingEventArgs>? Scp1509Resurrecting;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerScp1509ResurrectedEventArgs>? Scp1509Resurrected;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerDamagingShootingTargetEventArgs>? DamagingShootingTarget;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerDamagedShootingTargetEventArgs>? DamagedShootingTarget;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerDamagingWindowEventArgs>? DamagingWindow;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerDamagedWindowEventArgs>? DamagedWindow;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerEnteringPocketDimensionEventArgs>? EnteringPocketDimension;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerEnteredPocketDimensionEventArgs>? EnteredPocketDimension;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerLeavingPocketDimensionEventArgs>? LeavingPocketDimension;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerLeftPocketDimensionEventArgs>? LeftPocketDimension;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerTriggeringTeslaEventArgs>? TriggeringTesla;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerTriggeredTeslaEventArgs>? TriggeredTesla;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerEscapingEventArgs>? Escaping;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerEscapedEventArgs>? Escaped;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerFlippingCoinEventArgs>? FlippingCoin;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerFlippedCoinEventArgs>? FlippedCoin;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchingToyEventArgs>? SearchingToy;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchedToyEventArgs>? SearchedToy;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchToyAbortedEventArgs>? SearchToyAborted;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerIdlingTeslaEventArgs>? IdlingTesla;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerIdledTeslaEventArgs>? IdledTesla;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingDoorEventArgs>? InteractingDoor;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedDoorEventArgs>? InteractedDoor;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingElevatorEventArgs>? InteractingElevator;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedElevatorEventArgs>? InteractedElevator;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingGeneratorEventArgs>? InteractingGenerator;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedGeneratorEventArgs>? InteractedGenerator;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerOpeningGeneratorEventArgs>? OpeningGenerator;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerOpenedGeneratorEventArgs>? OpenedGenerator;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerActivatingGeneratorEventArgs>? ActivatingGenerator;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerActivatedGeneratorEventArgs>? ActivatedGenerator;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerDeactivatingGeneratorEventArgs>? DeactivatingGenerator;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerDeactivatedGeneratorEventArgs>? DeactivatedGenerator;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUnlockingGeneratorEventArgs>? UnlockingGenerator;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUnlockedGeneratorEventArgs>? UnlockedGenerator;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerClosingGeneratorEventArgs>? ClosingGenerator;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerClosedGeneratorEventArgs>? ClosedGenerator;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingLockerEventArgs>? InteractingLocker;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedLockerEventArgs>? InteractedLocker;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingScp330EventArgs>? InteractingScp330;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedScp330EventArgs>? InteractedScp330;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingShootingTargetEventArgs>? InteractingShootingTarget;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedShootingTargetEventArgs>? InteractedShootingTarget;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerPlacingBloodEventArgs>? PlacingBlood;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerPlacedBloodEventArgs>? PlacedBlood;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerPlacingBulletHoleEventArgs>? PlacingBulletHole;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerPlacedBulletHoleEventArgs>? PlacedBulletHole;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSpawningRagdollEventArgs>? SpawningRagdoll;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSpawnedRagdollEventArgs>? SpawnedRagdoll;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUnlockingWarheadButtonEventArgs>? UnlockingWarheadButton;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerUnlockedWarheadButtonEventArgs>? UnlockedWarheadButton;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerReceivedAchievementEventArgs>? ReceivedAchievement;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerRoomChangedEventArgs>? RoomChanged;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerZoneChangedEventArgs>? ZoneChanged;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingWarheadLeverEventArgs>? InteractingWarheadLever;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedWarheadLeverEventArgs>? InteractedWarheadLever;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSendingHitmarkerEventArgs>? SendingHitmarker;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerSentHitmarkerEventArgs>? SentHitmarker;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerCheckedHitmarkerEventArgs>? CheckedHitmarker;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedSpectatorEventArgs>? ChangedSpectator;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerEnteringHazardEventArgs>? EnteringHazard;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerEnteredHazardEventArgs>? EnteredHazard;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayersStayingInHazardEventArgs>? StayingInHazard;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerLeavingHazardEventArgs>? LeavingHazard;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerLeftHazardEventArgs>? LeftHazard;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerValidatedVisibilityEventArgs>? ValidatedVisibility;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.PlayerEvents.PlayerDetectedByScp1344EventArgs>? DetectedByScp1344;

		public static void OnJoined(global::LabApi.Events.Arguments.PlayerEvents.PlayerJoinedEventArgs ev)
		{
			Joined.InvokeEvent(ev);
		}

		public static void OnLeft(global::LabApi.Events.Arguments.PlayerEvents.PlayerLeftEventArgs ev)
		{
			Left.InvokeEvent(ev);
		}

		public static void OnReceivingVoiceMessage(global::LabApi.Events.Arguments.PlayerEvents.PlayerReceivingVoiceMessageEventArgs ev)
		{
			ReceivingVoiceMessage.InvokeEvent(ev);
		}

		public static void OnSendingVoiceMessage(global::LabApi.Events.Arguments.PlayerEvents.PlayerSendingVoiceMessageEventArgs ev)
		{
			SendingVoiceMessage.InvokeEvent(ev);
		}

		public static void OnPreAuthenticating(global::LabApi.Events.Arguments.PlayerEvents.PlayerPreAuthenticatingEventArgs ev)
		{
			PreAuthenticating.InvokeEvent(ev);
		}

		public static void OnPreAuthenticated(global::LabApi.Events.Arguments.PlayerEvents.PlayerPreAuthenticatedEventArgs ev)
		{
			PreAuthenticated.InvokeEvent(ev);
		}

		public static void OnUsingIntercom(global::LabApi.Events.Arguments.PlayerEvents.PlayerUsingIntercomEventArgs ev)
		{
			UsingIntercom.InvokeEvent(ev);
		}

		public static void OnUsedIntercom(global::LabApi.Events.Arguments.PlayerEvents.PlayerUsedIntercomEventArgs ev)
		{
			UsedIntercom.InvokeEvent(ev);
		}

		public static void OnBanning(global::LabApi.Events.Arguments.PlayerEvents.PlayerBanningEventArgs ev)
		{
			Banning.InvokeEvent(ev);
		}

		public static void OnBanned(global::LabApi.Events.Arguments.PlayerEvents.PlayerBannedEventArgs ev)
		{
			Banned.InvokeEvent(ev);
		}

		public static void OnKicking(global::LabApi.Events.Arguments.PlayerEvents.PlayerKickingEventArgs ev)
		{
			Kicking.InvokeEvent(ev);
		}

		public static void OnKicked(global::LabApi.Events.Arguments.PlayerEvents.PlayerKickedEventArgs ev)
		{
			Kicked.InvokeEvent(ev);
		}

		public static void OnMuting(global::LabApi.Events.Arguments.PlayerEvents.PlayerMutingEventArgs ev)
		{
			Muting.InvokeEvent(ev);
		}

		public static void OnMuted(global::LabApi.Events.Arguments.PlayerEvents.PlayerMutedEventArgs ev)
		{
			Muted.InvokeEvent(ev);
		}

		public static void OnUnmuting(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnmutingEventArgs ev)
		{
			Unmuting.InvokeEvent(ev);
		}

		public static void OnUnmuted(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnmutedEventArgs ev)
		{
			Unmuted.InvokeEvent(ev);
		}

		public static void OnReportingCheater(global::LabApi.Events.Arguments.PlayerEvents.PlayerReportingCheaterEventArgs ev)
		{
			ReportingCheater.InvokeEvent(ev);
		}

		public static void OnReportedCheater(global::LabApi.Events.Arguments.PlayerEvents.PlayerReportedCheaterEventArgs ev)
		{
			ReportedCheater.InvokeEvent(ev);
		}

		public static void OnReportingPlayer(global::LabApi.Events.Arguments.PlayerEvents.PlayerReportingPlayerEventArgs ev)
		{
			ReportingPlayer.InvokeEvent(ev);
		}

		public static void OnReportedPlayer(global::LabApi.Events.Arguments.PlayerEvents.PlayerReportedPlayerEventArgs ev)
		{
			ReportedPlayer.InvokeEvent(ev);
		}

		public static void OnTogglingNoclip(global::LabApi.Events.Arguments.PlayerEvents.PlayerTogglingNoclipEventArgs ev)
		{
			TogglingNoclip.InvokeEvent(ev);
		}

		public static void OnToggledNoclip(global::LabApi.Events.Arguments.PlayerEvents.PlayerToggledNoclipEventArgs ev)
		{
			ToggledNoclip.InvokeEvent(ev);
		}

		public static void OnRequestingRaPlayerList(global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestingRaPlayerListEventArgs ev)
		{
			RequestingRaPlayerList.InvokeEvent(ev);
		}

		public static void OnRequestedRaPlayerList(global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestedRaPlayerListEventArgs ev)
		{
			RequestedRaPlayerList.InvokeEvent(ev);
		}

		public static void OnRaPlayerListAddingPlayer(global::LabApi.Events.Arguments.PlayerEvents.PlayerRaPlayerListAddingPlayerEventArgs ev)
		{
			RaPlayerListAddingPlayer.InvokeEvent(ev);
		}

		public static void OnRaPlayerListAddedPlayer(global::LabApi.Events.Arguments.PlayerEvents.PlayerRaPlayerListAddedPlayerEventArgs ev)
		{
			RaPlayerListAddedPlayer.InvokeEvent(ev);
		}

		public static void OnRequestedCustomRaInfo(global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestedCustomRaInfoEventArgs ev)
		{
			RequestedCustomRaInfo.InvokeEvent(ev);
		}

		public static void OnRequestingRaPlayersInfo(global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestingRaPlayersInfoEventArgs ev)
		{
			RequestingRaPlayersInfo.InvokeEvent(ev);
		}

		public static void OnRequestedRaPlayersInfo(global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestedRaPlayersInfoEventArgs ev)
		{
			RequestedRaPlayersInfo.InvokeEvent(ev);
		}

		public static void OnRequestingRaPlayerInfo(global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestingRaPlayerInfoEventArgs ev)
		{
			RequestingRaPlayerInfo.InvokeEvent(ev);
		}

		public static void OnRequestedRaPlayerInfo(global::LabApi.Events.Arguments.PlayerEvents.PlayerRequestedRaPlayerInfoEventArgs ev)
		{
			RequestedRaPlayerInfo.InvokeEvent(ev);
		}

		public static void OnChangingBadgeVisibility(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingBadgeVisibilityEventArgs ev)
		{
			ChangingBadgeVisibility.InvokeEvent(ev);
		}

		public static void OnChangedBadgeVisibility(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedBadgeVisibilityEventArgs ev)
		{
			ChangedBadgeVisibility.InvokeEvent(ev);
		}

		public static void OnChangingNickname(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingNicknameEventArgs ev)
		{
			ChangingNickname.InvokeEvent(ev);
		}

		public static void OnChangedNickname(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedNicknameEventArgs ev)
		{
			ChangedNickname.InvokeEvent(ev);
		}

		public static void OnGroupChanging(global::LabApi.Events.Arguments.PlayerEvents.PlayerGroupChangingEventArgs ev)
		{
			GroupChanging.InvokeEvent(ev);
		}

		public static void OnGroupChanged(global::LabApi.Events.Arguments.PlayerEvents.PlayerGroupChangedEventArgs ev)
		{
			GroupChanged.InvokeEvent(ev);
		}

		public static void OnUpdatingEffect(global::LabApi.Events.Arguments.PlayerEvents.PlayerEffectUpdatingEventArgs ev)
		{
			UpdatingEffect.InvokeEvent(ev);
		}

		public static void OnUpdatedEffect(global::LabApi.Events.Arguments.PlayerEvents.PlayerEffectUpdatedEventArgs ev)
		{
			UpdatedEffect.InvokeEvent(ev);
		}

		public static void OnDying(global::LabApi.Events.Arguments.PlayerEvents.PlayerDyingEventArgs ev)
		{
			Dying.InvokeEvent(ev);
		}

		public static void OnDeath(global::LabApi.Events.Arguments.PlayerEvents.PlayerDeathEventArgs ev)
		{
			Death.InvokeEvent(ev);
		}

		public static void OnHurting(global::LabApi.Events.Arguments.PlayerEvents.PlayerHurtingEventArgs ev)
		{
			Hurting.InvokeEvent(ev);
		}

		public static void OnHurt(global::LabApi.Events.Arguments.PlayerEvents.PlayerHurtEventArgs ev)
		{
			Hurt.InvokeEvent(ev);
		}

		public static void OnChangingRole(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingRoleEventArgs ev)
		{
			ChangingRole.InvokeEvent(ev);
		}

		public static void OnChangedRole(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedRoleEventArgs ev)
		{
			ChangedRole.InvokeEvent(ev);
		}

		public static void OnCuffing(global::LabApi.Events.Arguments.PlayerEvents.PlayerCuffingEventArgs ev)
		{
			Cuffing.InvokeEvent(ev);
		}

		public static void OnCuffed(global::LabApi.Events.Arguments.PlayerEvents.PlayerCuffedEventArgs ev)
		{
			Cuffed.InvokeEvent(ev);
		}

		public static void OnUncuffing(global::LabApi.Events.Arguments.PlayerEvents.PlayerUncuffingEventArgs ev)
		{
			Uncuffing.InvokeEvent(ev);
		}

		public static void OnUncuffed(global::LabApi.Events.Arguments.PlayerEvents.PlayerUncuffedEventArgs ev)
		{
			Uncuffed.InvokeEvent(ev);
		}

		public static void OnReceivingLoadout(global::LabApi.Events.Arguments.PlayerEvents.PlayerReceivingLoadoutEventArgs ev)
		{
			ReceivingLoadout.InvokeEvent(ev);
		}

		public static void OnReceivedLoadout(global::LabApi.Events.Arguments.PlayerEvents.PlayerReceivedLoadoutEventArgs ev)
		{
			ReceivedLoadout.InvokeEvent(ev);
		}

		public static void OnSpawning(global::LabApi.Events.Arguments.PlayerEvents.PlayerSpawningEventArgs ev)
		{
			Spawning.InvokeEvent(ev);
		}

		public static void OnSpawned(global::LabApi.Events.Arguments.PlayerEvents.PlayerSpawnedEventArgs ev)
		{
			Spawned.InvokeEvent(ev);
		}

		public static void OnChangingItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingItemEventArgs ev)
		{
			ChangingItem.InvokeEvent(ev);
		}

		public static void OnChangedItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedItemEventArgs ev)
		{
			ChangedItem.InvokeEvent(ev);
		}

		public static void OnDroppingAmmo(global::LabApi.Events.Arguments.PlayerEvents.PlayerDroppingAmmoEventArgs ev)
		{
			DroppingAmmo.InvokeEvent(ev);
		}

		public static void OnDroppedAmmo(global::LabApi.Events.Arguments.PlayerEvents.PlayerDroppedAmmoEventArgs ev)
		{
			DroppedAmmo.InvokeEvent(ev);
		}

		public static void OnDroppingItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerDroppingItemEventArgs ev)
		{
			DroppingItem.InvokeEvent(ev);
		}

		public static void OnDroppedItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerDroppedItemEventArgs ev)
		{
			DroppedItem.InvokeEvent(ev);
		}

		public static void OnPickingUpAmmo(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickingUpAmmoEventArgs ev)
		{
			PickingUpAmmo.InvokeEvent(ev);
		}

		public static void OnPickedUpAmmo(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickedUpAmmoEventArgs ev)
		{
			PickedUpAmmo.InvokeEvent(ev);
		}

		public static void OnPickingUpArmor(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickingUpArmorEventArgs ev)
		{
			PickingUpArmor.InvokeEvent(ev);
		}

		public static void OnPickedUpArmor(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickedUpArmorEventArgs ev)
		{
			PickedUpArmor.InvokeEvent(ev);
		}

		public static void OnPickingUpItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickingUpItemEventArgs ev)
		{
			PickingUpItem.InvokeEvent(ev);
		}

		public static void OnPickedUpItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickedUpItemEventArgs ev)
		{
			PickedUpItem.InvokeEvent(ev);
		}

		public static void OnPickingUpScp330(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickingUpScp330EventArgs ev)
		{
			PickingUpScp330.InvokeEvent(ev);
		}

		public static void OnPickedUpScp330(global::LabApi.Events.Arguments.PlayerEvents.PlayerPickedUpScp330EventArgs ev)
		{
			PickedUpScp330.InvokeEvent(ev);
		}

		public static void OnSearchedAmmo(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchedAmmoEventArgs ev)
		{
			SearchedAmmo.InvokeEvent(ev);
		}

		public static void OnSearchingArmor(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchingArmorEventArgs ev)
		{
			SearchingArmor.InvokeEvent(ev);
		}

		public static void OnSearchedArmor(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchedArmorEventArgs ev)
		{
			SearchedArmor.InvokeEvent(ev);
		}

		public static void OnSearchingPickup(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchingPickupEventArgs ev)
		{
			SearchingPickup.InvokeEvent(ev);
		}

		public static void OnInteractedToy(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedToyEventArgs ev)
		{
			InteractedToy.InvokeEvent(ev);
		}

		public static void OnSearchedPickup(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchedPickupEventArgs ev)
		{
			SearchedPickup.InvokeEvent(ev);
		}

		public static void OnSearchingAmmo(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchingAmmoEventArgs ev)
		{
			SearchingAmmo.InvokeEvent(ev);
		}

		public static void OnThrowingItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerThrowingItemEventArgs ev)
		{
			ThrowingItem.InvokeEvent(ev);
		}

		public static void OnThrewItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerThrewItemEventArgs ev)
		{
			ThrewItem.InvokeEvent(ev);
		}

		public static void OnThrowingProjectile(global::LabApi.Events.Arguments.PlayerEvents.PlayerThrowingProjectileEventArgs ev)
		{
			ThrowingProjectile.InvokeEvent(ev);
		}

		public static void OnThrewProjectile(global::LabApi.Events.Arguments.PlayerEvents.PlayerThrewProjectileEventArgs ev)
		{
			ThrewProjectile.InvokeEvent(ev);
		}

		public static void OnInspectingKeycard(global::LabApi.Events.Arguments.PlayerEvents.PlayerInspectingKeycardEventArgs ev)
		{
			InspectingKeycard.InvokeEvent(ev);
		}

		public static void OnInspectedKeycard(global::LabApi.Events.Arguments.PlayerEvents.PlayerInspectedKeycardEventArgs ev)
		{
			InspectedKeycard.InvokeEvent(ev);
		}

		public static void OnSpinningRevolver(global::LabApi.Events.Arguments.PlayerEvents.PlayerSpinningRevolverEventArgs ev)
		{
			SpinningRevolver.InvokeEvent(ev);
		}

		public static void OnSpinnedRevolver(global::LabApi.Events.Arguments.PlayerEvents.PlayerSpinnedRevolverEventArgs ev)
		{
			SpinnedRevolver.InvokeEvent(ev);
		}

		public static void OnToggledDisruptorFiringMode(global::LabApi.Events.Arguments.PlayerEvents.PlayerToggledDisruptorFiringModeEventArgs ev)
		{
			ToggledDisruptorFiringMode.InvokeEvent(ev);
		}

		public static void OnInspectingItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerInspectingItemEventArgs ev)
		{
			InspectingItem.InvokeEvent(ev);
		}

		public static void OnInspectedItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerInspectedItemEventArgs ev)
		{
			InspectedItem.InvokeEvent(ev);
		}

		public static void OnUsingItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerUsingItemEventArgs ev)
		{
			UsingItem.InvokeEvent(ev);
		}

		public static void OnUsedItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerUsedItemEventArgs ev)
		{
			UsedItem.InvokeEvent(ev);
		}

		public static void OnItemUsageEffectsApplying(global::LabApi.Events.Arguments.PlayerEvents.PlayerItemUsageEffectsApplyingEventArgs ev)
		{
			ItemUsageEffectsApplying.InvokeEvent(ev);
		}

		public static void OnUsingRadio(global::LabApi.Events.Arguments.PlayerEvents.PlayerUsingRadioEventArgs ev)
		{
			UsingRadio.InvokeEvent(ev);
		}

		public static void OnUsedRadio(global::LabApi.Events.Arguments.PlayerEvents.PlayerUsedRadioEventArgs ev)
		{
			UsedRadio.InvokeEvent(ev);
		}

		public static void OnAimedWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerAimedWeaponEventArgs ev)
		{
			AimedWeapon.InvokeEvent(ev);
		}

		public static void OnDryFiringWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerDryFiringWeaponEventArgs ev)
		{
			DryFiringWeapon.InvokeEvent(ev);
		}

		public static void OnDryFiredWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerDryFiredWeaponEventArgs ev)
		{
			DryFiredWeapon.InvokeEvent(ev);
		}

		public static void OnUnloadingWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnloadingWeaponEventArgs ev)
		{
			UnloadingWeapon.InvokeEvent(ev);
		}

		public static void OnUnloadedWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnloadedWeaponEventArgs ev)
		{
			UnloadedWeapon.InvokeEvent(ev);
		}

		public static void OnReloadingWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerReloadingWeaponEventArgs ev)
		{
			ReloadingWeapon.InvokeEvent(ev);
		}

		public static void OnReloadedWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerReloadedWeaponEventArgs ev)
		{
			ReloadedWeapon.InvokeEvent(ev);
		}

		public static void OnShootingWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerShootingWeaponEventArgs ev)
		{
			ShootingWeapon.InvokeEvent(ev);
		}

		public static void OnShotWeapon(global::LabApi.Events.Arguments.PlayerEvents.PlayerShotWeaponEventArgs ev)
		{
			ShotWeapon.InvokeEvent(ev);
		}

		public static void OnChangingAttachments(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingAttachmentsEventArgs ev)
		{
			ChangingAttachments.InvokeEvent(ev);
		}

		public static void OnChangedAttachments(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedAttachmentsEventArgs ev)
		{
			ChangedAttachments.InvokeEvent(ev);
		}

		public static void OnSendingAttachmentsPrefs(global::LabApi.Events.Arguments.PlayerEvents.PlayerSendingAttachmentsPrefsEventArgs ev)
		{
			SendingAttachmentsPrefs.InvokeEvent(ev);
		}

		public static void OnSentAttachmentsPrefs(global::LabApi.Events.Arguments.PlayerEvents.PlayerSentAttachmentsPrefsEventArgs ev)
		{
			SentAttachmentsPrefs.InvokeEvent(ev);
		}

		public static void OnCancellingUsingItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerCancellingUsingItemEventArgs ev)
		{
			CancellingUsingItem.InvokeEvent(ev);
		}

		public static void OnCancelledUsingItem(global::LabApi.Events.Arguments.PlayerEvents.PlayerCancelledUsingItemEventArgs ev)
		{
			CancelledUsingItem.InvokeEvent(ev);
		}

		public static void OnChangingRadioRange(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangingRadioRangeEventArgs ev)
		{
			ChangingRadioRange.InvokeEvent(ev);
		}

		public static void OnChangedRadioRange(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedRadioRangeEventArgs ev)
		{
			ChangedRadioRange.InvokeEvent(ev);
		}

		public static void OnProcessingJailbirdMessage(global::LabApi.Events.Arguments.PlayerEvents.PlayerProcessingJailbirdMessageEventArgs ev)
		{
			ProcessingJailbirdMessage.InvokeEvent(ev);
		}

		public static void OnProcessedJailbirdMessage(global::LabApi.Events.Arguments.PlayerEvents.PlayerProcessedJailbirdMessageEventArgs ev)
		{
			ProcessedJailbirdMessage.InvokeEvent(ev);
		}

		public static void OnTogglingFlashlight(global::LabApi.Events.Arguments.PlayerEvents.PlayerTogglingFlashlightEventArgs ev)
		{
			TogglingFlashlight.InvokeEvent(ev);
		}

		public static void OnToggledFlashlight(global::LabApi.Events.Arguments.PlayerEvents.PlayerToggledFlashlightEventArgs ev)
		{
			ToggledFlashlight.InvokeEvent(ev);
		}

		public static void OnTogglingWeaponFlashlight(global::LabApi.Events.Arguments.PlayerEvents.PlayerTogglingWeaponFlashlightEventArgs ev)
		{
			TogglingWeaponFlashlight.InvokeEvent(ev);
		}

		public static void OnToggledWeaponFlashlight(global::LabApi.Events.Arguments.PlayerEvents.PlayerToggledWeaponFlashlightEventArgs ev)
		{
			ToggledWeaponFlashlight.InvokeEvent(ev);
		}

		public static void OnTogglingRadio(global::LabApi.Events.Arguments.PlayerEvents.PlayerTogglingRadioEventArgs ev)
		{
			TogglingRadio.InvokeEvent(ev);
		}

		public static void OnToggledRadio(global::LabApi.Events.Arguments.PlayerEvents.PlayerToggledRadioEventArgs ev)
		{
			ToggledRadio.InvokeEvent(ev);
		}

		public static void OnJumped(global::LabApi.Events.Arguments.PlayerEvents.PlayerJumpedEventArgs ev)
		{
			Jumped.InvokeEvent(ev);
		}

		public static void OnMovementStateChanged(global::LabApi.Events.Arguments.PlayerEvents.PlayerMovementStateChangedEventArgs ev)
		{
			MovementStateChanged.InvokeEvent(ev);
		}

		public static void OnProcessingScp1509Message(global::LabApi.Events.Arguments.PlayerEvents.PlayerProcessingScp1509MessageEventArgs ev)
		{
			ProcessingScp1509Message.InvokeEvent(ev);
		}

		public static void OnProcessedScp1509Message(global::LabApi.Events.Arguments.PlayerEvents.PlayerProcessedScp1509MessageEventArgs ev)
		{
			ProcessedScp1509Message.InvokeEvent(ev);
		}

		public static void OnScp1509Resurrecting(global::LabApi.Events.Arguments.PlayerEvents.PlayerScp1509ResurrectingEventArgs ev)
		{
			Scp1509Resurrecting.InvokeEvent(ev);
		}

		public static void OnScp1509Resurrected(global::LabApi.Events.Arguments.PlayerEvents.PlayerScp1509ResurrectedEventArgs ev)
		{
			Scp1509Resurrected.InvokeEvent(ev);
		}

		public static void OnDamagingShootingTarget(global::LabApi.Events.Arguments.PlayerEvents.PlayerDamagingShootingTargetEventArgs ev)
		{
			DamagingShootingTarget.InvokeEvent(ev);
		}

		public static void OnDamagedShootingTarget(global::LabApi.Events.Arguments.PlayerEvents.PlayerDamagedShootingTargetEventArgs ev)
		{
			DamagedShootingTarget.InvokeEvent(ev);
		}

		public static void OnDamagingWindow(global::LabApi.Events.Arguments.PlayerEvents.PlayerDamagingWindowEventArgs ev)
		{
			DamagingWindow.InvokeEvent(ev);
		}

		public static void OnDamagedWindow(global::LabApi.Events.Arguments.PlayerEvents.PlayerDamagedWindowEventArgs ev)
		{
			DamagedWindow.InvokeEvent(ev);
		}

		public static void OnEnteringPocketDimension(global::LabApi.Events.Arguments.PlayerEvents.PlayerEnteringPocketDimensionEventArgs ev)
		{
			EnteringPocketDimension.InvokeEvent(ev);
		}

		public static void OnEnteredPocketDimension(global::LabApi.Events.Arguments.PlayerEvents.PlayerEnteredPocketDimensionEventArgs ev)
		{
			EnteredPocketDimension.InvokeEvent(ev);
		}

		public static void OnLeavingPocketDimension(global::LabApi.Events.Arguments.PlayerEvents.PlayerLeavingPocketDimensionEventArgs ev)
		{
			LeavingPocketDimension.InvokeEvent(ev);
		}

		public static void OnLeftPocketDimension(global::LabApi.Events.Arguments.PlayerEvents.PlayerLeftPocketDimensionEventArgs ev)
		{
			LeftPocketDimension.InvokeEvent(ev);
		}

		public static void OnTriggeringTesla(global::LabApi.Events.Arguments.PlayerEvents.PlayerTriggeringTeslaEventArgs ev)
		{
			TriggeringTesla.InvokeEvent(ev);
		}

		public static void OnTriggeredTesla(global::LabApi.Events.Arguments.PlayerEvents.PlayerTriggeredTeslaEventArgs ev)
		{
			TriggeredTesla.InvokeEvent(ev);
		}

		public static void OnEscaping(global::LabApi.Events.Arguments.PlayerEvents.PlayerEscapingEventArgs ev)
		{
			Escaping.InvokeEvent(ev);
		}

		public static void OnEscaped(global::LabApi.Events.Arguments.PlayerEvents.PlayerEscapedEventArgs ev)
		{
			Escaped.InvokeEvent(ev);
		}

		public static void OnFlippingCoin(global::LabApi.Events.Arguments.PlayerEvents.PlayerFlippingCoinEventArgs ev)
		{
			FlippingCoin.InvokeEvent(ev);
		}

		public static void OnFlippedCoin(global::LabApi.Events.Arguments.PlayerEvents.PlayerFlippedCoinEventArgs ev)
		{
			FlippedCoin.InvokeEvent(ev);
		}

		public static void OnSearchingToy(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchingToyEventArgs ev)
		{
			SearchingToy.InvokeEvent(ev);
		}

		public static void OnSearchedToy(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchedToyEventArgs ev)
		{
			SearchedToy.InvokeEvent(ev);
		}

		public static void OnSearchToyAborted(global::LabApi.Events.Arguments.PlayerEvents.PlayerSearchToyAbortedEventArgs ev)
		{
			SearchToyAborted.InvokeEvent(ev);
		}

		public static void OnIdlingTesla(global::LabApi.Events.Arguments.PlayerEvents.PlayerIdlingTeslaEventArgs ev)
		{
			IdlingTesla.InvokeEvent(ev);
		}

		public static void OnIdledTesla(global::LabApi.Events.Arguments.PlayerEvents.PlayerIdledTeslaEventArgs ev)
		{
			IdledTesla.InvokeEvent(ev);
		}

		public static void OnInteractingDoor(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingDoorEventArgs ev)
		{
			InteractingDoor.InvokeEvent(ev);
		}

		public static void OnInteractedDoor(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedDoorEventArgs ev)
		{
			InteractedDoor.InvokeEvent(ev);
		}

		public static void OnInteractingElevator(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingElevatorEventArgs ev)
		{
			InteractingElevator.InvokeEvent(ev);
		}

		public static void OnInteractedElevator(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedElevatorEventArgs ev)
		{
			InteractedElevator.InvokeEvent(ev);
		}

		public static void OnInteractingGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingGeneratorEventArgs ev)
		{
			InteractingGenerator.InvokeEvent(ev);
		}

		public static void OnInteractedGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedGeneratorEventArgs ev)
		{
			InteractedGenerator.InvokeEvent(ev);
		}

		public static void OnOpeningGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerOpeningGeneratorEventArgs ev)
		{
			OpeningGenerator.InvokeEvent(ev);
		}

		public static void OnOpenedGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerOpenedGeneratorEventArgs ev)
		{
			OpenedGenerator.InvokeEvent(ev);
		}

		public static void OnActivatingGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerActivatingGeneratorEventArgs ev)
		{
			ActivatingGenerator.InvokeEvent(ev);
		}

		public static void OnActivatedGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerActivatedGeneratorEventArgs ev)
		{
			ActivatedGenerator.InvokeEvent(ev);
		}

		public static void OnDeactivatingGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerDeactivatingGeneratorEventArgs ev)
		{
			DeactivatingGenerator.InvokeEvent(ev);
		}

		public static void OnDeactivatedGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerDeactivatedGeneratorEventArgs ev)
		{
			DeactivatedGenerator.InvokeEvent(ev);
		}

		public static void OnUnlockingGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnlockingGeneratorEventArgs ev)
		{
			UnlockingGenerator.InvokeEvent(ev);
		}

		public static void OnUnlockedGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnlockedGeneratorEventArgs ev)
		{
			UnlockedGenerator.InvokeEvent(ev);
		}

		public static void OnClosingGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerClosingGeneratorEventArgs ev)
		{
			ClosingGenerator.InvokeEvent(ev);
		}

		public static void OnClosedGenerator(global::LabApi.Events.Arguments.PlayerEvents.PlayerClosedGeneratorEventArgs ev)
		{
			ClosedGenerator.InvokeEvent(ev);
		}

		public static void OnInteractingLocker(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingLockerEventArgs ev)
		{
			InteractingLocker.InvokeEvent(ev);
		}

		public static void OnInteractedLocker(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedLockerEventArgs ev)
		{
			InteractedLocker.InvokeEvent(ev);
		}

		public static void OnInteractingScp330(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingScp330EventArgs ev)
		{
			InteractingScp330.InvokeEvent(ev);
		}

		public static void OnInteractedScp330(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedScp330EventArgs ev)
		{
			InteractedScp330.InvokeEvent(ev);
		}

		public static void OnInteractingShootingTarget(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingShootingTargetEventArgs ev)
		{
			InteractingShootingTarget.InvokeEvent(ev);
		}

		public static void OnInteractedShootingTarget(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedShootingTargetEventArgs ev)
		{
			InteractedShootingTarget.InvokeEvent(ev);
		}

		public static void OnPlacingBlood(global::LabApi.Events.Arguments.PlayerEvents.PlayerPlacingBloodEventArgs ev)
		{
			PlacingBlood.InvokeEvent(ev);
		}

		public static void OnPlacedBlood(global::LabApi.Events.Arguments.PlayerEvents.PlayerPlacedBloodEventArgs ev)
		{
			PlacedBlood.InvokeEvent(ev);
		}

		public static void OnPlacingBulletHole(global::LabApi.Events.Arguments.PlayerEvents.PlayerPlacingBulletHoleEventArgs ev)
		{
			PlacingBulletHole.InvokeEvent(ev);
		}

		public static void OnPlacedBulletHole(global::LabApi.Events.Arguments.PlayerEvents.PlayerPlacedBulletHoleEventArgs ev)
		{
			PlacedBulletHole.InvokeEvent(ev);
		}

		public static void OnSpawningRagdoll(global::LabApi.Events.Arguments.PlayerEvents.PlayerSpawningRagdollEventArgs ev)
		{
			SpawningRagdoll.InvokeEvent(ev);
		}

		public static void OnSpawnedRagdoll(global::LabApi.Events.Arguments.PlayerEvents.PlayerSpawnedRagdollEventArgs ev)
		{
			SpawnedRagdoll.InvokeEvent(ev);
		}

		public static void OnUnlockingWarheadButton(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnlockingWarheadButtonEventArgs ev)
		{
			UnlockingWarheadButton.InvokeEvent(ev);
		}

		public static void OnUnlockedWarheadButton(global::LabApi.Events.Arguments.PlayerEvents.PlayerUnlockedWarheadButtonEventArgs ev)
		{
			UnlockedWarheadButton.InvokeEvent(ev);
		}

		public static void OnReceivedAchievement(global::LabApi.Events.Arguments.PlayerEvents.PlayerReceivedAchievementEventArgs ev)
		{
			ReceivedAchievement.InvokeEvent(ev);
		}

		public static void OnRoomChanged(global::LabApi.Events.Arguments.PlayerEvents.PlayerRoomChangedEventArgs ev)
		{
			RoomChanged.InvokeEvent(ev);
		}

		public static void OnZoneChanged(global::LabApi.Events.Arguments.PlayerEvents.PlayerZoneChangedEventArgs ev)
		{
			ZoneChanged.InvokeEvent(ev);
		}

		public static void OnInteractingWarheadLever(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractingWarheadLeverEventArgs ev)
		{
			InteractingWarheadLever.InvokeEvent(ev);
		}

		public static void OnInteractedWarheadLever(global::LabApi.Events.Arguments.PlayerEvents.PlayerInteractedWarheadLeverEventArgs ev)
		{
			InteractedWarheadLever.InvokeEvent(ev);
		}

		public static void OnSendingHitmarker(global::LabApi.Events.Arguments.PlayerEvents.PlayerSendingHitmarkerEventArgs ev)
		{
			SendingHitmarker.InvokeEvent(ev);
		}

		public static void OnSentHitmarker(global::LabApi.Events.Arguments.PlayerEvents.PlayerSentHitmarkerEventArgs ev)
		{
			SentHitmarker.InvokeEvent(ev);
		}

		public static void OnCheckedHitmarker(global::LabApi.Events.Arguments.PlayerEvents.PlayerCheckedHitmarkerEventArgs ev)
		{
			CheckedHitmarker.InvokeEvent(ev);
		}

		public static void OnChangedSpectator(global::LabApi.Events.Arguments.PlayerEvents.PlayerChangedSpectatorEventArgs ev)
		{
			ChangedSpectator.InvokeEvent(ev);
		}

		public static void OnEnteringHazard(global::LabApi.Events.Arguments.PlayerEvents.PlayerEnteringHazardEventArgs ev)
		{
			EnteringHazard.InvokeEvent(ev);
		}

		public static void OnEnteredHazard(global::LabApi.Events.Arguments.PlayerEvents.PlayerEnteredHazardEventArgs ev)
		{
			EnteredHazard.InvokeEvent(ev);
		}

		public static void OnStayingInHazard(global::LabApi.Events.Arguments.PlayerEvents.PlayersStayingInHazardEventArgs ev)
		{
			StayingInHazard.InvokeEvent(ev);
		}

		public static void OnLeavingHazard(global::LabApi.Events.Arguments.PlayerEvents.PlayerLeavingHazardEventArgs ev)
		{
			LeavingHazard.InvokeEvent(ev);
		}

		public static void OnLeftHazard(global::LabApi.Events.Arguments.PlayerEvents.PlayerLeftHazardEventArgs ev)
		{
			LeftHazard.InvokeEvent(ev);
		}

		public static void OnValidatedVisibility(global::LabApi.Events.Arguments.PlayerEvents.PlayerValidatedVisibilityEventArgs ev)
		{
			ValidatedVisibility.InvokeEvent(ev);
		}

		public static void OnDetectedByScp1344(global::LabApi.Events.Arguments.PlayerEvents.PlayerDetectedByScp1344EventArgs ev)
		{
			DetectedByScp1344.InvokeEvent(ev);
		}
	}
}
