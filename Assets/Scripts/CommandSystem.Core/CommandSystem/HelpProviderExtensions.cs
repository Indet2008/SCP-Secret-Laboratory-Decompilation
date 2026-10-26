namespace CommandSystem
{
	public static class HelpProviderExtensions
	{
		public static string DisplayCommandUsage(this global::CommandSystem.IUsageProvider provider)
		{
			global::System.Text.StringBuilder stringBuilder = global::NorthwoodLib.Pools.StringBuilderPool.Shared.Rent();
			string[] usage = provider.Usage;
			for (int i = 0; i < usage.Length; i++)
			{
				string value = usage[i].Replace("%player%", "PlayerIDs/PlayerNames").Replace("%role%", "Role Name").Replace("%door%", "Door Name")
					.Replace("%item%", "Item ID");
				stringBuilder.Append("[");
				stringBuilder.Append(value);
				stringBuilder.Append("] ");
			}
			return global::NorthwoodLib.Pools.StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}
	}
}
