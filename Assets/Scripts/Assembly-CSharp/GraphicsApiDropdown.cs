using UnityEngine;

public class GraphicsApiDropdown : MonoBehaviour
{
	private enum GraphicsApi
	{
		Auto = 0,
		DirectX11 = 1,
		DirectX12 = 2,
		Vulkan = 3
	}

	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	[global::UnityEngine.SerializeField]
	private global::UnityEngine.GameObject _forcedWarning;


}
