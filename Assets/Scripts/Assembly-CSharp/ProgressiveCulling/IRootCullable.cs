namespace ProgressiveCulling
{
	public interface IRootCullable : ICullable
	{
		RootCullablePriority Priority { get; }

		void SetupCache();
	}
}
