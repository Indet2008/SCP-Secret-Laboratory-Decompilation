public class DropdownArrowRotator : global::UnityEngine.MonoBehaviour
{
	public global::UnityEngine.UI.Image ArrowImage;

	private void OnEnable()
	{
		ArrowImage.transform.rotation = global::UnityEngine.Quaternion.Euler(180f, 0f, 0f);
	}

	private void OnDestroy()
	{
		ArrowImage.transform.rotation = global::UnityEngine.Quaternion.Euler(0f, 0f, 0f);
	}

	public DropdownArrowRotator()
	{
	}
}
