namespace InventorySystem.Items.Firearms.Modules
{
	public readonly struct DisplayInaccuracyValues
	{
		public readonly float HipDeg;

		public readonly float AdsDeg;

		public readonly float RunningDeg;

		public readonly float BulletDeg;

		public float GetHipAccurateRange(bool imperial, bool rounded)
		{
			return IDisplayableInaccuracyProviderModule.GetDisplayAccurateRange(HipDeg, imperial, rounded);
		}

		public float GetAdsAccurateRange(bool imperial, bool rounded)
		{
			return IDisplayableInaccuracyProviderModule.GetDisplayAccurateRange(AdsDeg, imperial, rounded);
		}

		public float GetRunningAccurateRange(bool imperial, bool rounded)
		{
			return IDisplayableInaccuracyProviderModule.GetDisplayAccurateRange(RunningDeg, imperial, rounded);
		}

		public DisplayInaccuracyValues(float hip = 0f, float ads = 0f, float running = 0f, float bullet = 0f)
		{
			HipDeg = hip;
			AdsDeg = ads;
			RunningDeg = running;
			BulletDeg = bullet;
		}
	}
}
