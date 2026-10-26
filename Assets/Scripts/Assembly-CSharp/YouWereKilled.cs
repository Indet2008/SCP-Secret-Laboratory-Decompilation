using UnityEngine;

public class YouWereKilled : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public global::UnityEngine.UI.Text _info;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.AudioClip _deathBell;


	public static YouWereKilled Singleton;

	[Space]
	public GameObject _root;
}
