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
		UpdateNoclip(hub);
	}

	private void UpdateNoclip(ReferenceHub hub)
	{
		FpcNoclip fpcNoclip = ((hub.roleManager.CurrentRole is IFpcRole fpcRole) ? fpcRole.FpcModule.Noclip : null);
		bool flag = fpcNoclip != null && fpcNoclip.IsActive;
		SetActiveSafe(noclipUI, flag);
		if (flag)
		{
			if (noclipIndicator != null)
			{
				noclipIndicator.text = "NOCLIP ENABLED - SPEED: " + FpcNoclip.CurSpeed.ToString("0.#");
			}
			if (fogIndicator != null)
			{
				fogIndicator.text = "FOG: " + (FpcNoclip.FogDisabled ? "OFF" : "ON");
			}
		}
	}

	private static void SetActiveSafe(GameObject go, bool state)
	{
		if (go != null && go.activeSelf != state)
		{
			go.SetActive(state);
		}
	}
}
