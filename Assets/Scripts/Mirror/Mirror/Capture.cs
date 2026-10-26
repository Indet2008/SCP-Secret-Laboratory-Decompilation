namespace Mirror
{
	public interface Capture
	{
		double timestamp { get; set; }

		void DrawGizmo();
	}
}
