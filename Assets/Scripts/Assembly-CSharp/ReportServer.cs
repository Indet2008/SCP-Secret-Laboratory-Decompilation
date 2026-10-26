using UnityEngine;

public class ReportServer : MonoBehaviour
{
	private enum CentralResponse : byte
	{
		None = 0,
		Success = 1,
		Error = 2
	}

	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public global::UnityEngine.GameObject root;

	public global::TMPro.TextMeshProUGUI ipAddress;

	public global::TMPro.TextMeshProUGUI warningText;

	public global::UnityEngine.GameObject description;

	public global::UnityEngine.GameObject form;

	public global::UnityEngine.GameObject report;

	public global::UnityEngine.GameObject confirmation;


}
