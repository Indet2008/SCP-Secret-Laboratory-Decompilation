using UnityEngine;

public class ScpInterfaces : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public global::TMPro.TextMeshProUGUI Scp049_decayedPopup;

	public global::UnityEngine.UI.Image Scp049_loading;

	public global::UnityEngine.UI.Image Scp049_cooldown;

	public global::TMPro.TextMeshProUGUI remainingTargets;

	public global::UnityEngine.UI.Image Scp173EyeIndicator;

	public global::UnityEngine.UI.Image Scp173TantrumCooldown;

	public global::UnityEngine.UI.Image Scp173BreakneckCooldown;

	public global::TMPro.TextMeshProUGUI Scp173BlinkTimer;


	public static ScpInterfaces singleton;

	public GameObject Scp106_eq;

	public GameObject Scp049_eq;

	public GameObject Scp096_eq;

	public GameObject Scp173InterfaceObj;

	public static int remTargs;

	private void Awake()
	{
		singleton = this;
	}
}
