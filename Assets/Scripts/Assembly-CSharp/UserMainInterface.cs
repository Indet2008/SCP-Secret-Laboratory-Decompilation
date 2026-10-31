using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

public class UserMainInterface : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public global::UnityEngine.UI.Text playerlistText;

	public global::UnityEngine.UI.Text voiceInfo;

	public global::TMPro.TextMeshProUGUI hintText;

	[global::UnityEngine.Space]
	[global::UnityEngine.Serialization.FormerlySerializedAs("fps")]
	public global::UnityEngine.UI.Text Ping;

	public global::UnityEngine.GameObject noclipUI;

	public global::UnityEngine.UI.Text noclipIndicator;

	public global::UnityEngine.UI.Text fogIndicator;

	public global::UnityEngine.UI.Text noclipHelpText;

	[global::UnityEngine.Header("Searching")]
	public global::UnityEngine.GameObject searchObject;

	public global::UnityEngine.UI.Image searchRadial;

	[global::UnityEngine.Header("Popup")]
	public global::UnityEngine.CanvasGroup imageDisplayGroup;

	public global::UnityEngine.UI.Image imageToDisplay;

	public global::UnityEngine.GameObject mouseGameObject;

	public global::UnityEngine.GameObject PlyStats;


	public static UserMainInterface singleton;

	public float LerpSpeed = 4f;

	private void Awake()
	{
		singleton = this;
	}

	private void Start()
	{
		if (noclipUI != null)
		{
			noclipUI.SetActive(value: false);
		}
		if (searchObject != null)
		{
			searchObject.SetActive(value: false);
		}
	}

	private void Update()
	{
		if (!ReferenceHub.TryGetLocalHub(out var hub))
		{
			SetActiveSafe(PlyStats, state: false);
			SetActiveSafe(noclipUI, state: false);
			return;
		}
		// Search radial is driven by SearchCoordinator.UpdateClient.
		SetActiveSafe(PlyStats, hub.IsAlive() && hub.roleManager.CurrentRole is IHealthbarRole);
	}

	// Original (called by FpcNoclip.UpdateNoclip in the client build).
	public void SetNoclipIndicator(bool state, float speed)
	{
		noclipUI.SetActive(state);
		if (state)
		{
			noclipIndicator.text = string.Format("Noclip speed: {0:0.##} m/s", speed);
			UpdateFogIndicator();
			noclipHelpText.text = string.Format("Toggle Noclip: <b>{0}</b>\n", new ReadableKeyCode(NewInput.GetKey(ActionName.Noclip))) + "Change Speed: <b>Mouse Wheel</b>\n" + string.Format("Toggle Fog: <b>{0}</b>", new ReadableKeyCode(NewInput.GetKey(ActionName.NoClipFogToggle)));
		}
	}

	public void UpdateFogIndicator()
	{
		CustomRendering.FogController singleton = CustomRendering.FogController.Singleton;
		fogIndicator.text = ((singleton != null && singleton.gameObject.activeSelf) ? "Fog Enabled" : "Fog Disabled");
	}

	private static void SetActiveSafe(GameObject go, bool state)
	{
		if (go != null && go.activeSelf != state)
		{
			go.SetActive(state);
		}
	}
}
