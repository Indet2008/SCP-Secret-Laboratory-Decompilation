public class GraphicsDropdown : global::UnityEngine.MonoBehaviour
{
	public DropDownController controller;

	private void Start()
	{
		controller.EnableOption(2, global::UnityEngine.SystemInfo.operatingSystemFamily == global::UnityEngine.OperatingSystemFamily.Windows && global::System.Environment.OSVersion.Version.Major >= 10);
	}

	public GraphicsDropdown()
	{
	}
}
