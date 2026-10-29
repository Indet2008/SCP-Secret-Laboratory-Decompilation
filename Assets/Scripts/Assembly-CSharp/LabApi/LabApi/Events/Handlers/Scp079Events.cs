namespace LabApi.Events.Handlers
{
	public static class Scp079Events
	{
		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079BlackingOutRoomEventsArgs>? BlackingOutRoom;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079BlackedOutRoomEventArgs>? BlackedOutRoom;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079BlackingOutZoneEventArgs>? BlackingOutZone;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079BlackedOutZoneEventArgs>? BlackedOutZone;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079ChangingCameraEventArgs>? ChangingCamera;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079ChangedCameraEventArgs>? ChangedCamera;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079CancellingRoomLockdownEventArgs>? CancellingRoomLockdown;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079CancelledRoomLockdownEventArgs>? CancelledRoomLockdown;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079GainingExperienceEventArgs>? GainingExperience;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079GainedExperienceEventArgs>? GainedExperience;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079LevelingUpEventArgs>? LevelingUp;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079LeveledUpEventArgs>? LeveledUp;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079LockingDoorEventArgs>? LockingDoor;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079LockedDoorEventArgs>? LockedDoor;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079LockingDownRoomEventArgs>? LockingDownRoom;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079LockedDownRoomEventArgs>? LockedDownRoom;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079RecontainingEventArgs>? Recontaining;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079RecontainedEventArgs>? Recontained;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079UnlockingDoorEventArgs>? UnlockingDoor;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079UnlockedDoorEventArgs>? UnlockedDoor;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079UsingTeslaEventArgs>? UsingTesla;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079UsedTeslaEventArgs>? UsedTesla;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079PingingEventArgs>? Pinging;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp079Events.Scp079PingedEventArgs>? Pinged;

		public static void OnBlackingOutRoom(global::LabApi.Events.Arguments.Scp079Events.Scp079BlackingOutRoomEventsArgs ev)
		{
			BlackingOutRoom.InvokeEvent(ev);
		}

		public static void OnBlackedOutRoom(global::LabApi.Events.Arguments.Scp079Events.Scp079BlackedOutRoomEventArgs ev)
		{
			BlackedOutRoom.InvokeEvent(ev);
		}

		public static void OnBlackingOutZone(global::LabApi.Events.Arguments.Scp079Events.Scp079BlackingOutZoneEventArgs ev)
		{
			BlackingOutZone.InvokeEvent(ev);
		}

		public static void OnBlackedOutZone(global::LabApi.Events.Arguments.Scp079Events.Scp079BlackedOutZoneEventArgs ev)
		{
			BlackedOutZone.InvokeEvent(ev);
		}

		public static void OnChangingCamera(global::LabApi.Events.Arguments.Scp079Events.Scp079ChangingCameraEventArgs ev)
		{
			ChangingCamera.InvokeEvent(ev);
		}

		public static void OnChangedCamera(global::LabApi.Events.Arguments.Scp079Events.Scp079ChangedCameraEventArgs ev)
		{
			ChangedCamera.InvokeEvent(ev);
		}

		public static void OnCancellingRoomLockdown(global::LabApi.Events.Arguments.Scp079Events.Scp079CancellingRoomLockdownEventArgs ev)
		{
			CancellingRoomLockdown.InvokeEvent(ev);
		}

		public static void OnCancelledRoomLockdown(global::LabApi.Events.Arguments.Scp079Events.Scp079CancelledRoomLockdownEventArgs ev)
		{
			CancelledRoomLockdown.InvokeEvent(ev);
		}

		public static void OnGainingExperience(global::LabApi.Events.Arguments.Scp079Events.Scp079GainingExperienceEventArgs ev)
		{
			GainingExperience.InvokeEvent(ev);
		}

		public static void OnGainedExperience(global::LabApi.Events.Arguments.Scp079Events.Scp079GainedExperienceEventArgs ev)
		{
			GainedExperience.InvokeEvent(ev);
		}

		public static void OnLevelingUp(global::LabApi.Events.Arguments.Scp079Events.Scp079LevelingUpEventArgs ev)
		{
			LevelingUp.InvokeEvent(ev);
		}

		public static void OnLeveledUp(global::LabApi.Events.Arguments.Scp079Events.Scp079LeveledUpEventArgs ev)
		{
			LeveledUp.InvokeEvent(ev);
		}

		public static void OnLockingDoor(global::LabApi.Events.Arguments.Scp079Events.Scp079LockingDoorEventArgs ev)
		{
			LockingDoor.InvokeEvent(ev);
		}

		public static void OnLockedDoor(global::LabApi.Events.Arguments.Scp079Events.Scp079LockedDoorEventArgs ev)
		{
			LockedDoor.InvokeEvent(ev);
		}

		public static void OnLockingDownRoom(global::LabApi.Events.Arguments.Scp079Events.Scp079LockingDownRoomEventArgs ev)
		{
			LockingDownRoom.InvokeEvent(ev);
		}

		public static void OnLockedDownRoom(global::LabApi.Events.Arguments.Scp079Events.Scp079LockedDownRoomEventArgs ev)
		{
			LockedDownRoom.InvokeEvent(ev);
		}

		public static void OnRecontaining(global::LabApi.Events.Arguments.Scp079Events.Scp079RecontainingEventArgs ev)
		{
			Recontaining.InvokeEvent(ev);
		}

		public static void OnRecontained(global::LabApi.Events.Arguments.Scp079Events.Scp079RecontainedEventArgs ev)
		{
			Recontained.InvokeEvent(ev);
		}

		public static void OnUnlockingDoor(global::LabApi.Events.Arguments.Scp079Events.Scp079UnlockingDoorEventArgs ev)
		{
			UnlockingDoor.InvokeEvent(ev);
		}

		public static void OnUnlockedDoor(global::LabApi.Events.Arguments.Scp079Events.Scp079UnlockedDoorEventArgs ev)
		{
			UnlockedDoor.InvokeEvent(ev);
		}

		public static void OnUsingTesla(global::LabApi.Events.Arguments.Scp079Events.Scp079UsingTeslaEventArgs ev)
		{
			UsingTesla.InvokeEvent(ev);
		}

		public static void OnUsedTesla(global::LabApi.Events.Arguments.Scp079Events.Scp079UsedTeslaEventArgs ev)
		{
			UsedTesla.InvokeEvent(ev);
		}

		public static void OnPinging(global::LabApi.Events.Arguments.Scp079Events.Scp079PingingEventArgs ev)
		{
			Pinging.InvokeEvent(ev);
		}

		public static void OnPinged(global::LabApi.Events.Arguments.Scp079Events.Scp079PingedEventArgs ev)
		{
			Pinged.InvokeEvent(ev);
		}
	}
}
