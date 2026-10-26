using MapGeneration.Decoration;

namespace Interactables.Interobjects.DoorUtils
{
	public class DoorAnimateAlarmsExtension : DoorVariantExtension
	{
		public EnvironmentalAlarm[] Alarms;

		public bool EnableOnOpen = true;

		public bool EnableOnClose = true;

		public bool EnableOnMoving = true;

		public bool EnableOnPry = true;

		private bool _previousState;

		private void Start()
		{
			EnvironmentalAlarm[] alarms = Alarms;
			for (int i = 0; i < alarms.Length; i++)
			{
				alarms[i].IsEnabled = false;
			}
		}

		private void Update()
		{
			bool targetState = TargetDoor.TargetState;
			bool isMoving = TargetDoor.IsMoving;
			bool flag = TargetDoor is PryableDoor pryableDoor && pryableDoor.IsBeingPried;
			bool flag2 = (EnableOnPry || !flag) && ((EnableOnOpen & targetState) || (EnableOnClose && !targetState) || (EnableOnMoving & isMoving) || (EnableOnPry & flag));
			if (flag2 != _previousState)
			{
				_previousState = flag2;
				EnvironmentalAlarm[] alarms = Alarms;
				for (int i = 0; i < alarms.Length; i++)
				{
					alarms[i].IsEnabled = flag2;
				}
			}
		}
	}
}
