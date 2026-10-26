namespace ProgressiveCulling
{
	public interface ICullable
	{
		bool ShouldBeVisible { get; }

		void SetVisibility(bool isVisible);

		void UpdateState()
		{
			SetVisibility(ShouldBeVisible);
		}
	}
}
