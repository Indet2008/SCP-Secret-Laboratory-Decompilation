namespace UserSettings.ServerSpecific.Entries
{
	public interface ISSEntry
	{
		bool CheckCompatibility(ServerSpecificSettingBase setting);

		void Init(ServerSpecificSettingBase setting);
	}
}
