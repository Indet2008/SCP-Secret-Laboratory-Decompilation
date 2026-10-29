namespace LabApi.Features.Wrappers
{
	public static class Decontamination
	{
		public static global::LightContainmentZoneDecontamination.DecontaminationController.DecontaminationStatus Status
		{
			get
			{
				return global::LightContainmentZoneDecontamination.DecontaminationController.Singleton.DecontaminationOverride;
			}
			set
			{
				global::LightContainmentZoneDecontamination.DecontaminationController.Singleton.DecontaminationOverride = value;
			}
		}

		public static bool IsDecontaminating => global::LightContainmentZoneDecontamination.DecontaminationController.Singleton.IsDecontaminating;

		public static double ServerTime => global::LightContainmentZoneDecontamination.DecontaminationController.GetServerTime;

		public static double RoundStartTime => global::LightContainmentZoneDecontamination.DecontaminationController.Singleton.RoundStartTime;

		public static float Offset
		{
			get
			{
				return global::LightContainmentZoneDecontamination.DecontaminationController.Singleton.TimeOffset;
			}
			set
			{
				global::LightContainmentZoneDecontamination.DecontaminationController.Singleton.TimeOffset = value;
			}
		}

		public static string ElevatorsText
		{
			get
			{
				return global::LightContainmentZoneDecontamination.DecontaminationController.Singleton.ElevatorsLockedText;
			}
			set
			{
				global::LightContainmentZoneDecontamination.DecontaminationController.Singleton.ElevatorsLockedText = value;
			}
		}
	}
}
