using UnityEngine;
using UnityEngine.SceneManagement;

public class PlayButton : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public global::UnityEngine.UI.Text Motd;

	public global::UnityEngine.UI.Text Players;

	public uint AccountID;

	public uint ServerID;

	public string Ip;

	public string Port;

	public string InfoType;


	private void Start()
	{
		if (SceneManager.GetActiveScene().name == "Facility")
		{
			Object.Destroy(base.gameObject);
		}
	}
}
